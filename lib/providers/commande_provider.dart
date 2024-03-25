import 'dart:collection';
import 'dart:convert';

import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/providers/call_api.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      if (c.id == id) {
        return c;
      }
    }
    return null;
  }

  /// Récupérer toutes mes commandes
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
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 200) {
      _commandes = (jsonDecode(reponseApi.response!.body) as List)
          .map((c) => Commande.fromJson(c))
          .toList();

      afficherLogInfo("Récupération des commandes terminée.");
    }

    if (reponseApi.response!.statusCode != 200) {
      afficherLogError("La récupération des commandes a échoué.");
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"] ??
            "La récupération des commandes a échoué.",
      };
    }

    notifyListeners();
  }

  /// Récupère toutes les commandes qui existent
  Future<dynamic> fetchAllCommandes(String token) async {
    _commandes = [];
    commandesRecuperees = false;
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
      timeoutSec: 6,
    );

    commandesRecuperees = true;
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 200) {
      _commandes = (jsonDecode(reponseApi.response!.body) as List)
          .map((c) => Commande.fromJson(c))
          .toList();

      afficherLogInfo("Récupération des commandes terminée.");
    }

    if (reponseApi.response!.statusCode != 200) {
      afficherLogError("La récupération des commandes a échoué.");
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"] ??
            "La récupération des commandes a échoué.",
      };
    }

    notifyListeners();
  }

  /// Récupérer une commande grâce à son identifiant
  Future<dynamic> fetchCommande(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/orders/$idCommande',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
      timeoutSec: 5,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 200) {
      _commande = Commande.fromJson(jsonDecode(reponseApi.response!.body));
      afficherLogInfo("Récupération de la commande terminée.");
    }

    if (reponseApi.response!.statusCode != 200) {
      afficherLogError("La récupération de la commande a échoué.");
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"] ??
            "La récupération de la commande a échoué.",
      };
    }

    notifyListeners();
  }

  /// Création d'une commande
  Future<dynamic> creerCommande(String token, Panier panier) async {
    panier.toJson();
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders',
      typeRequeteHttp: TypeRequeteHttp.POST,
      token: token,
      jsonBody: panier.toJson(),
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    if (response.statusCode != 201) {
      return {
        "statusCode": response.statusCode,
        "message": json.decode(response.body)["message"] ??
            "La création de la commande n'a pas pu aboutir.",
      };
    }

    int idCommande = json.decode(response.body)["id"];
    return {
      "statusCode": 201,
      "message": "L'événement a été créé avec succès.",
      "idCommande": idCommande,
    };
  }

  /// Permet d'annuler une commande grâce à son identifiant
  Future<dynamic> annulerCommande(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/$idCommande/cancel',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a bien été annulée.",
      };
    }
    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": json.decode(reponseApi.response!.body)["message"] ??
          "La commande n'a pas pu être annulée.",
    };
  }

  /// Permet de changer le statut d'une commande en PAYÉE
  Future<dynamic> passerCommandePayee(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/$idCommande/pay',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a été payée.",
      };
    }
    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": json.decode(reponseApi.response!.body)["message"] ??
          "Un erreur est survenue, le paiement n'a pas été validé.",
    };
  }

  /// Permet de changer le statut des commande d'un événement en À RETIRER
  Future<dynamic> passerCommandeEnRetrait(String token, int idEvenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/$idEvenement/collect',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message":
            "Les commandes sont passées au statut 'En attente de retrait'.",
      };
    }
    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": json.decode(reponseApi.response!.body)["message"] ??
          "Une erreur est survenue, les commandes ne sont pas passées au statut en attente retrait",
    };
  }

  /// Permet de changer le statut des commande d'un événement en RETIRÉE
  Future<dynamic> passerCommandeRetiree(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/$idCommande/collected',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 204) {
      cloturerCommande(token, idCommande);

      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a été retirée.",
      };
    }
    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": json.decode(reponseApi.response!.body)["message"] ??
          "Une erreur est survenue, la commande n'a pas été retirée.",
    };
  }

  /// Permet de clôturer une commande grâce à son identifiant
  Future<dynamic> cloturerCommande(String token, int idCommande) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/orders/$idCommande/close',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
      timeoutSec: 6,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a bien été clôturée.",
      };
    }
    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": json.decode(reponseApi.response!.body)["message"] ??
          "Une erreur est survenue, la commande n'a pas été clôturé.",
    };
  }

  /// Permet de récupérer les commandes selon leur statut
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

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    if (reponseApi.response?.statusCode != 200) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"] ??
            "Une erreur est survenue, le Qr Code n'a pas été récupéré",
      };
    }

    _qrCode = json.decode(reponseApi.response!.body)["qrCode"];
    afficherLogInfo("Récupération du Qr Code terminé.");
    notifyListeners();
  }
}
