import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/evenement.dart';
import 'call_api.dart';

class EvenementProvider extends ChangeNotifier {
  List<Evenement> _evenements = [];

  UnmodifiableListView<Evenement> get evenements =>
      UnmodifiableListView(_evenements);

  Future<void> fetchData() async {
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
