import 'dart:convert';

import 'package:ape_manager_front/forms/reinit_mdp_form.dart';
import 'package:ape_manager_front/models/enfant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../forms/modification_mdp_form.dart';
import '../models/utilisateur.dart';
import 'call_api.dart';

class UtilisateurProvider with ChangeNotifier {
  bool isLoading = false;
  Utilisateur? _utilisateur;

  Utilisateur? get utilisateur => _utilisateur;

  List<Enfant> get enfants => _utilisateur!.enfants;

  void updateUser(Utilisateur? u) {
    _utilisateur = u;
    notifyListeners();
  }

  Future<dynamic> fetchEnfants() async {
    // Appel à l'API
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/utilisateurs/${_utilisateur?.id}/children',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );
    isLoading = false;
    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) return;
    try {
      _utilisateur!.setEnfants(jsonDecode(reponseApi.response!.body) as List);
    } catch (_) {
      _utilisateur!.setEnfants([]);
    } finally {
      notifyListeners();
    }
  }

  // Appel à l'API pour demander la réinitialisation du mot de passe d'un compte
  Future<dynamic> demandeReinitMdp(String? email) async {
    isLoading = true;
    print("[PROVIDER] => DEMANDE REINIT MDP - non pris en charge");
    isLoading = false;
    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  // Appel à l'API pour réinitialiser le mot de passe d'un compte
  // Redirigé ici par l'API après une demande de réinitialisation du mdp
  Future<dynamic> reinitMdp(ReinitMdpForm reinitMdpForm) async {
    isLoading = true;
    print("[PROVIDER] => REINIT MDP - non pris en charge");
    isLoading = false;
    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  // Appel à l'API pour modifier le mot de passe
  // Accessible en étant connecté dans "Mon profil"
  Future<dynamic> modifierMotDePasse(
      ModificationMdpForm modificationMdpForm) async {
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/change_password',
      jsonBody: modificationMdpForm.toJson(),
      typeRequeteHttp: TypeRequeteHttp.PUT,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message": "Le mot de passe a bien été modifié.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  Future<dynamic> modifierInformationsUtilisateur(
      Utilisateur utilisateurModifie) async {
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/utilisateurs/${_utilisateur!.id}',
      jsonBody: utilisateurModifie.toJsonModifDetails(),
      typeRequeteHttp: TypeRequeteHttp.PUT,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message": "Les modifications ont bien été apportées.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  Future<dynamic> supprimerCompte() async {
    isLoading = true;
    print("[PROVIDER] => SUPPRIMER COMPTE UTILISATEUR - non pris en charge");
    isLoading = false;

    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  Future<dynamic> ajouterEnfant(Enfant enfant) async {
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/utilisateurs/${_utilisateur!.id}/child',
      jsonBody: enfant.toJson(),
      typeRequeteHttp: TypeRequeteHttp.POST,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 200) {
      fetchEnfants();
      return {
        "statusCode": 200,
        "message": "L'enfant a bien été ajouté.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  Future<dynamic> modifierEnfant(Enfant enfant) async {
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/utilisateurs/${_utilisateur!.id}/enfants/${enfant.id}',
      jsonBody: enfant.toJson(),
      typeRequeteHttp: TypeRequeteHttp.PUT,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 200) {
      fetchEnfants();
      return {
        "statusCode": 200,
        "message": "Les informations de l'enfant ont bien été mises à jour.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  Future<dynamic> supprimerEnfant(Enfant enfant) async {
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/utilisateurs/${_utilisateur!.id}/enfants/${enfant.id}',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 204) {
      return {
        "statusCode": 200,
        "message": "L'enfant a bien été détaché de votre compte.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }
}
