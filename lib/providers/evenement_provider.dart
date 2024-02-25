import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/evenement.dart';
import 'call_api.dart';

class EvenementProvider with ChangeNotifier {
  List<Evenement> _evenements = [];
  UnmodifiableListView<Evenement> get evenements => UnmodifiableListView(_evenements);

  List<Evenement> getEvenements() => evenements;

  Future<void> fetchData() async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/evenements',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );

    if(!reponseApi.connexionAPIEtablie) return;

    _evenements = (jsonDecode(reponseApi.response!.body) as List)
        .map((e) => Evenement.fromJson(e))
        .toList();
    notifyListeners();
  }
}