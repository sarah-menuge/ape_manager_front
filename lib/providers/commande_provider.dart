import 'dart:collection';
import 'dart:convert';

import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/providers/call_api.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';

class CommandeProvider with ChangeNotifier {
  List<Commande> _commandes = [];
  Commande? _commande;
  bool commandesRecuperees = false;
  String _qrCode = "";

  UnmodifiableListView<Commande> get commandes =>
      UnmodifiableListView(_commandes);

  String get qrCode => _qrCode;

  Commande? get commande => _commande;

  Commande? getCommande(int id) {
    for (Commande c in _commandes) {
      if (c.id == id) return c;
    }
    return null;
  }

  Future<dynamic> fetchCommandes(String token) async {
    _commandes = [];
    commandesRecuperees = false;
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/orders',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
      timeoutSec: 6,
    );

    commandesRecuperees = true;
    if (!reponseApi.connexionAPIEtablie) return;

    if (reponseApi.response?.statusCode != 200) return;

    _commandes = (jsonDecode(reponseApi.response!.body) as List)
        .map((c) => Commande.fromJson(c))
        .toList();

    afficherLogInfo("Récupération des commandes terminée.");

    notifyListeners();
  }

  Future<dynamic> fetchCommande(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/orders/$idCommande',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
      timeoutSec: 5,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    if (reponseApi.response!.statusCode != 200) {
      afficherLogError("La récupération de la commande a échoué.");
    }

    _commande = Commande.fromJson(jsonDecode(reponseApi.response!.body));
    afficherLogInfo("Récupération de la commande terminée.");

    notifyListeners();
  }

  Future<dynamic> annulerCommande(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/$idCommande/cancel',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    if (reponseApi.response?.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a bien été annulée.",
      };
    }
    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": json.decode(reponseApi.response!.body)["message"],
    };
  }

  List<Commande> getCommandesEnCours() {
    return _commandes
        .where(
          (commande) => [
            StatutCommande.VALIDEE,
            StatutCommande.A_RETIRER,
            StatutCommande.RETIREE,
          ].contains(commande.statut),
        )
        .toList();
  }

  List<Commande> getCommandesPassees() {
    return _commandes
        .where(
          (commande) => [
            StatutCommande.ANNULEE,
            StatutCommande.CLOTUREE,
          ].contains(commande.statut),
        )
        .toList();
  }

  /// Récupération du QRCode
  Future<dynamic> getQrCodeCommande(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/qrcode/$idCommande',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    if (reponseApi.response?.statusCode != 200) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"],
      };
    }

    _qrCode = json.decode(reponseApi.response!.body)["qrCode"];
    afficherLogInfo("Récupération du Qr Code terminé.");
    notifyListeners();
  }
}
