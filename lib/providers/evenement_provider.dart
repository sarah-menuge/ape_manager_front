import 'dart:collection';
import 'dart:convert';

import 'package:ape_manager_front/forms/creation_evenement_form.dart';
import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/evenement.dart';
import 'call_api.dart';

class EvenementProvider extends ChangeNotifier {
  List<Evenement> _evenements = [];
  Evenement? _evenement;

  UnmodifiableListView<Evenement> get evenements =>
      UnmodifiableListView(_evenements);

  Evenement? get evenement => _evenement;

  Future<void> fetchEvenements(String token) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    _evenements = (jsonDecode(reponseApi.response!.body) as List)
        .map((e) => Evenement.fromJson(e))
        .toList();

    notifyListeners();
  }

  Future<void> fetchEvenement(String token, int eventId) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/$eventId',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      _evenement = Evenement.fromJson(body);
      afficherLogDebug("L'évènement $eventId a bien été récupéré.");
    } else {
      afficherLogError("L'évènement $eventId n'a pas pu être récupéré.");
    }

    notifyListeners();
  }

  Future<void> fetchListeArticles(String token, Evenement evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/items',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    if (reponseApi.response?.statusCode == 200) {
      evenement.setArticles((jsonDecode(reponseApi.response!.body) as List)
          .map((a) => Article.fromJson(a))
          .toList());
    }

    notifyListeners();
  }

  Future<void> fetchListeCommandes(String token, Evenement evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/orders',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    if (reponseApi.response?.statusCode == 200) {
      evenement.setCommandes((jsonDecode(reponseApi.response!.body) as List)
          .map((c) => Commande.fromJson(c))
          .toList());
    }

    notifyListeners();
  }

  Future<dynamic> creerEvenement(
      String token, CreationEvenementForm creationEvenementForm) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/',
      typeRequeteHttp: TypeRequeteHttp.POST,
      token: token,
      jsonBody: creationEvenementForm.toJson(),
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    if (response.statusCode != 201) {
      String err;
      try {
        err = json.decode(response.body)["message"];
      } catch (e) {
        err = "La création de l'événement n'a pas pu aboutir.";
      }
      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 201,
      "message": "L'événement a été créé avec succès.",
    };
  }

  /// Permet de récupérer les événements selon leur statut
  List<Evenement> getEvenementsBrouillon() {
    return _evenements
        .where((evenement) => evenement.statut == StatutEvenement.BROUILLON)
        .toList();
  }

  List<Evenement> getEvenementsAVenir() {
    return _evenements
        .where((evenement) => evenement.statut == StatutEvenement.A_VENIR)
        .toList();
  }

  List<Evenement> getEvenementsEnCours() {
    return _evenements
        .where((evenement) => evenement.statut == StatutEvenement.EN_COURS)
        .toList();
  }

  List<Evenement> getEvenementsCloture() {
    return _evenements
        .where((evenement) => evenement.statut == StatutEvenement.CLOTURE)
        .toList();
  }
}
