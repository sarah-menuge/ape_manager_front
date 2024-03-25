import 'dart:collection';
import 'dart:convert';

import 'package:ape_manager_front/forms/reinit_mdp_form.dart';
import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../forms/modification_mdp_form.dart';
import '../models/utilisateur.dart';
import 'call_api.dart';

enum Perspective { ADMIN, ORGANIZER, PARENT }

class UtilisateurProvider with ChangeNotifier {
  /// Lié à la gestion de l'utilisateur connecté
  Utilisateur? _utilisateur;
  List<Utilisateur> _utilisateurs = [];

  Utilisateur? get utilisateur => _utilisateur;

  List<Utilisateur> get utilisateurs => _utilisateurs;

  List<Enfant> get enfants => _utilisateur!.enfants;

  String? get token => _utilisateur?.token;

  /// Lié à la gestion de la perspective
  Perspective _perspective = Perspective.PARENT;

  Perspective get perspective => _perspective;

  void setPerspective(Perspective p) => _perspective = p;

  /// Lié à la gestion des rôles
  bool get estParent =>
      _utilisateur?.role == RoleUtilisateur.parent ||
      _utilisateur?.role == RoleUtilisateur.prof;

  bool get estProf => _utilisateur?.role == RoleUtilisateur.prof;

  bool get estOrganisateur =>
      _utilisateur?.role == RoleUtilisateur.organisateur;

  bool get estAdmin => _utilisateur?.role == RoleUtilisateur.administrateur;

  /// Lié à la récupération de la liste des organisateurs
  List<Organisateur> _organisateurs = [];

  UnmodifiableListView<Organisateur> get organisateurs =>
      UnmodifiableListView(_organisateurs);

  Future<dynamic> fetchListeOrganisateurs(String token) async {
    // Appel à l'API
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/organizers',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) return;

    http.Response response = reponseApi.response as http.Response;

    // Un problème avec la requête
    if (response.statusCode != 200) {
      return {
        "statusCode": response.statusCode,
        "message": json.decode(response.body)["message"],
      };
    }

    // Récupération de la liste des orgas
    _organisateurs = (json.decode(response.body) as List)
        .map((e) => Organisateur.fromJson(e))
        .toList();

    notifyListeners();
  }

  /// Méthode permettant de mettre à jour les informations concernant l'utilisateur connecté
  void updateUser(Utilisateur? u) {
    _utilisateur = u;
    notifyListeners();
  }

  Future<dynamic> fetchUtilisateurs(String token) async {
    // Appel à l'API
    ReponseAPI reponseApi = await callAPI(
      uri: '/users',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );
    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) return;
    _utilisateurs = (jsonDecode(reponseApi.response!.body) as List)
        .map((u) => Utilisateur.fromJson(u))
        .toList();
    notifyListeners();
  }

  Future<dynamic> fetchEnfants(String token) async {
    // Appel à l'API
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/user-children',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );
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

  /// Méthode permettant de demander la réinitialisation du mot de passe
  // Appel à l'API pour demander la réinitialisation du mot de passe d'un compte
  Future<dynamic> demandeReinitMdp(String email) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/forgotten/$email',
      typeRequeteHttp: TypeRequeteHttp.GET,
    );

    if (!reponseApi.connexionAPIEtablie) {
      afficherLogError(
          "La demande de réinitialisation de mot de passe n'a pas pu aboutir.");
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": reponseApi.response?.statusCode == 200
          ? "La demande de réinitialisation de mot de passe a bien été prise en compte. Veuillez vérifier vos mails."
          : json.decode(reponseApi.response!.body)["message"],
    };
  }

  // Appel à l'API pour réinitialiser le mot de passe d'un compte
  // Redirigé ici par l'API après une demande de réinitialisation du mdp
  Future<dynamic> reinitMdp(ReinitMdpForm reinitMdpForm) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/forgotten/',
      jsonBody: reinitMdpForm.toJson(),
      typeRequeteHttp: TypeRequeteHttp.POST,
    );

    if (!reponseApi.connexionAPIEtablie) {
      afficherLogError("La modification du mot de passe n'a pas pu aboutir.");
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    return {
      "statusCode": reponseApi.response?.statusCode,
      "message": reponseApi.response?.statusCode == 200
          ? "Le mot de passe a été modifié avec succès."
          : json.decode(reponseApi.response!.body)["message"],
    };
  }

  // Appel à l'API pour modifier le mot de passe
  // Accessible en étant connecté dans "Mon profil"
  Future<dynamic> modifierMotDePasse(
    String token,
    ModificationMdpForm modificationMdpForm,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/change_password',
      jsonBody: modificationMdpForm.toJson(),
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
    );

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
    String token,
    Utilisateur utilisateurModifie,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users',
      jsonBody: utilisateurModifie.toJsonModifDetails(),
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
    );

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

  Future<dynamic> supprimerCompte(String token) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
      token: token,
    );

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
        "statusCode": 204,
        "message": "Le compte a bien été supprimé.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"] ??
          "La suppression du compte a échoué.",
    };
  }

  Future<dynamic> ajouterEnfant(String token, Enfant enfant) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/child',
      jsonBody: enfant.toJson(),
      typeRequeteHttp: TypeRequeteHttp.POST,
      token: token,
    );

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 201) {
      fetchEnfants(token);
      return {
        "statusCode": response.statusCode,
        "message": "L'enfant a bien été ajouté.",
      };
    }

    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  Future<dynamic> modifierEnfant(String token, Enfant enfant) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/children/${enfant.id}',
      jsonBody: enfant.toJson(),
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
    );

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
      fetchEnfants(token);
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

  Future<dynamic> supprimerEnfant(String token, Enfant enfant) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/children/${enfant.id}',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
      token: token,
    );

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

  /// Suppression d'un utilisateur par l'administrateur
  Future<dynamic> supprimerUtilisateurAdmin(
      String token, int idUtilisateur) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/$idUtilisateur',
      typeRequeteHttp: TypeRequeteHttp.DELETE,
      token: token,
    );

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    if (response.statusCode == 204) {
      return {
        "statusCode": 204,
        "message": "Le compte de l'utilisateur a bien été supprimé.",
      };
    }

    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  Future<dynamic> modifierUtilisateurAdmin(String token, Utilisateur u) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/${u.id}',
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
      jsonBody: u.toJsonModifAdmin(),
    );

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message":
            "Les informations de l'utilisateur ont bien été mises à jour.",
      };
    }
    String err = json.decode(response.body)["message"] ??
        "Une erreur est survenue lors de la modification d'un utilisateur";
    return {
      "statusCode": response.statusCode,
      "message": err,
    };
  }

  /// Ajout de l'utilisateur courant dans une liste de diffusion de notification d'événement
  Future<dynamic> meNotifierParMailEvenement(
    String token,
    int evenementId,
  ) async {
    ReponseAPI reponseApi = await callAPI(
      uri: '/users/change-notify-me-start-event/${evenementId}',
      typeRequeteHttp: TypeRequeteHttp.PUT,
      token: token,
    );

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    if (response.statusCode == 200) {
      return {
        "statusCode": 200,
        "message": "Vous allez être notifié lorsque l'événement débutera.",
      };
    }
    String err = json.decode(response.body)["message"] ??
        "Impossible de vous ajouter dans la liste de diffusion.";
    return {
      "statusCode": response.statusCode,
      "message": err,
    };
  }
}
