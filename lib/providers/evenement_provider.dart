import 'dart:collection';
import 'dart:convert';

import 'package:ape_manager_front/forms/creation_modif_evenement_form.dart';
import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'call_api.dart';

class EvenementProvider extends ChangeNotifier {
  List<Evenement> _evenements = [];
  Evenement? _evenement;
  String _qrCode = "";

  UnmodifiableListView<Evenement> get evenements =>
      UnmodifiableListView(_evenements);

  String get qrCode => _qrCode;

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

  /// Récupération d'un événement
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
      String token, CreationModifEvenementForm creationEvenementForm) async {
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
      "id": json.decode(response.body)["id"],
    };
  }

  /// Passer l'événement au statut retrait
  Future<dynamic> passerEvenementEnRetrait(
      String token, int idEvenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/$idEvenement/pickup',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a été payée.",
      };
    } else {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a été payée.",
      };
    }
  }

  /// Passer l'événement au statut clôturé
  Future<dynamic> passerEvenementEnCloture(
      String token, int idEvenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/$idEvenement/close',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La commande a été payée.",
      };
    } else {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"],
      };
    }
  }

  /// Forcer la fin de paiement
  Future<dynamic> annulerCommandeNonPayees(
      String token, int idEvenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/$idEvenement/orders/cancel-unpaid',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "Les commandes non payées ont été annulées.",
      };
    } else {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"],
      };
    }
  }

  Future<dynamic> forcerFinPaiement(String token, int idEvenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/$idEvenement/endOfPayment/enable',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) return;

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 204) {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": "La fin de paiement a été établie.",
      };
    } else {
      return {
        "statusCode": reponseApi.response?.statusCode,
        "message": json.decode(reponseApi.response!.body)["message"],
      };
    }
  }

  /// Modification d'un événement
  Future<dynamic> modifierEvenement(String token, Evenement evenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}',
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
      jsonBody: evenement.toJsonInfosGenerales(),
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 200) {
      String err = json.decode(response.body)["message"] ??
          "La modification de l'événement n'a pas pu aboutir.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 200,
      "message": "L'événement a été modifié avec succès.",
    };
  }

  /// Ajout d'un nouvel organisateur à l'événement
  Future<dynamic> ajouterOrganisateur(
    String token,
    Evenement evenement,
    Organisateur organisateur,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/organizers/${organisateur.id}',
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 200) {
      String err = json.decode(response.body)["message"] ??
          "L'ajout de l'organisateur à l'événement n'a pas pu aboutir.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 200,
      "message": "L'organisateur a bien été ajouté à l'événement.",
    };
  }

  /// Suppression d'un nouvel organisateur à l'événement
  Future<dynamic> supprimerOrganisateur(
    String token,
    Evenement evenement,
    Organisateur organisateur,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/organizers/${organisateur.id}',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 200) {
      String err = json.decode(response.body)["message"] ??
          "L'organisateur n'a pas pu être supprimé de l'événement.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 200,
      "message": "L'organisateur a bien été supprimé de l'événement.",
    };
  }

  /// Ajout d'un article à un événément
  Future<dynamic> ajouterArticle(
    String token,
    Evenement evenement,
    Article article,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/items/',
      typeRequeteHttp: TypeRequeteHttp.POST,
      token: token,
      jsonBody: article.toJson(evenement.id),
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 201) {
      String err = json.decode(response.body)["message"] ??
          "La création de l'article a échoué.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 201,
      "message": "La création de l'article a bien été effectuée.",
      "id": json.decode(response.body)["id"],
    };
  }

  /// Modification d'un article associé à un événément
  Future<dynamic> modifierArticle(
    String token,
    Evenement evenement,
    Article article,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/items/${article.id}',
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
      jsonBody: article.toJson(null),
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 200) {
      String err = json.decode(response.body)["message"] ??
          "La modification de l'article a échoué.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 200,
      "message": "La modification de l'article a bien été effectuée.",
    };
  }

  /// Suppression d'un article associé à un événément
  Future<dynamic> supprimerArticle(
    String token,
    Evenement evenement,
    Article article,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/items/${article.id}',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 204) {
      String err = json.decode(response.body)["message"] ??
          "La suppression de l'article a échoué.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 204,
      "message": "L'article a bien été supprimé de l'événement.",
    };
  }

  /// Suppression d'un événement
  Future<dynamic> supprimerEvenement(
    String token,
    Evenement evenement,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 204) {
      String err = json.decode(response.body)["message"] ??
          "La suppression de l'événement a échoué.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 204,
      "message": "L'événement a bien été supprimé.",
    };
  }

  /// Publication de l'événement
  Future<dynamic> publierEvenement(
    String token,
    Evenement evenement,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/${evenement.id}/publish',
      typeRequeteHttp: TypeRequeteHttp.PATCH,
      token: token,
    );

    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode != 204) {
      String err = json.decode(response.body)["message"] ??
          "L'événement n'a pas pu être publié.";

      return {
        "statusCode": response.statusCode,
        "message": err,
      };
    }

    return {
      "statusCode": 204,
      "message": "L'événement a bien été publié.",
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
        .where((evenement) =>
            evenement.statut == StatutEvenement.EN_COURS ||
            evenement.statut == StatutEvenement.TRAITEMENT ||
            evenement.statut == StatutEvenement.RETRAIT)
        .toList();
  }

  List<Evenement> getEvenementsCloture() {
    return _evenements
        .where((evenement) => evenement.statut == StatutEvenement.CLOTURE)
        .toList();
  }

  /// Récupération du QRCode
  Future<dynamic> getQrCodeEvenement(String token, int idEvenement) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/events/qrcode/$idEvenement',
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
