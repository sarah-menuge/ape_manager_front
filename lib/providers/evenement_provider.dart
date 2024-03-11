import 'dart:collection';
import 'dart:convert';

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
  List<Article> _articles = [];
  Evenement? _evenement;
  List<Organisateur> _organisateurs = [];

  UnmodifiableListView<Evenement> get evenements =>
      UnmodifiableListView(_evenements);

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  Evenement? get evenement => _evenement;

  UnmodifiableListView<Organisateur> get organisateurs =>
      UnmodifiableListView(_organisateurs);

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

  Future<void> fetchOrganisateur(Evenement evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements/${evenement.id}',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );
    if (!reponseApi.connexionAPIEtablie) return;
    var jsonResponse = jsonDecode(reponseApi.response!.body);
    if (jsonResponse['organisateurs'] != null) {
      _organisateurs = (jsonResponse['organisateurs'] as List)
          .map((o) => Organisateur.fromJson(o))
          .toList();
    } else {
      _organisateurs = [];
    }

    notifyListeners();
  }

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

  Future<void> ajouterOrganisateur(
      Evenement evenement, Evenement nouvel_evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements/${evenement.id}',
      typeRequeteHttp: TypeRequeteHttp.PUT,
      jsonBody: nouvel_evenement.toJson(),
    );
  }
}
