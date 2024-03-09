import 'dart:collection';
import 'dart:convert';

import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/evenement.dart';
import 'call_api.dart';

class EvenementProvider extends ChangeNotifier {
  List<Evenement> _evenements = [];
  List<Article> _articles = [];
  Evenement? _evenement;

  UnmodifiableListView<Evenement> get evenements =>
      UnmodifiableListView(_evenements);

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  Evenement? get evenement => _evenement;

  Future<void> fetchEvenements() async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    _evenements = (jsonDecode(reponseApi.response!.body) as List)
        .map((e) => Evenement.fromJson(e))
        .toList();

    notifyListeners();
  }

  Future<void> fetchEvenement(int eventId) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements/$eventId',
      typeRequeteHttp: TypeRequeteHttp.GET,
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

  Future<void> fetchListeArticles(Evenement evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements/${evenement.id}/articles',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    evenement.setArticles((jsonDecode(reponseApi.response!.body) as List)
        .map((a) => Article.fromJson(a))
        .toList());

    notifyListeners();
  }

  Future<void> fetchListeCommandes(Evenement evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements/${evenement.id}/commandes',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    evenement.setCommandes((jsonDecode(reponseApi.response!.body) as List)
        .map((c) => Commande.fromJson(c))
        .toList());

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
}
