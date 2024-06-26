import 'dart:convert';

import 'package:ape_manager_front/forms/login_form.dart';
import 'package:ape_manager_front/forms/signup_form.dart';
import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/utils/stockage_hardware.dart';
import 'package:ape_manager_front/views/authentification/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'call_api.dart';

class AuthentificationProvider with ChangeNotifier {
  bool isLoading = false;
  bool isLoggedIn = false;

  // Permet d'interroger l'API pour s'authentifier
  Future<dynamic> signin(
    LoginForm loginForm,
    UtilisateurProvider utilisateurProvider,
  ) async {
    // Appel à l'API pour tenter de s'authentifier
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/login',
      jsonBody: loginForm.toJson(),
      typeRequeteHttp: TypeRequeteHttp.POST,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      isLoggedIn = false;
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    // Authentification OK
    if (response.statusCode == 200) {
      afficherLogInfo(
          "L'utilisateur [${loginForm.email}] s'est authentifié avec succès sous le role [${json.decode(response.body)["role"]}]");
      var body = json.decode(response.body);
      utilisateurProvider.updateUser(Utilisateur.fromJson(body));
      setValueInHardwareMemory(key: "token", value: body["token"]);
      isLoggedIn = true;
      return {
        "statusCode": 200,
        "message": null,
      };
    }
    // Authentification KO
    isLoggedIn = false;
    afficherLogInfo(
        "L'utilisateur [${loginForm.email}] n'a pas pu s'authentifier.");
    unsetValueInHardwareMemory(key: "token");

    String err = json.decode(response.body)["message"] ??
        "L'utilisateur n'a pas pu s'authentifier.";
    if (loginForm.email == "cyrille.dhalluin@univ-artois.fr" &&
        loginForm.password == "AlanKey") {
      err =
          "Un grand Homme (du jour) a dit un jour : \n\"Seuls les ignorants sont dans la capacité d’oublier leur mot de passe. Vous en faites malheureusement partie…\"";
    }

    return {
      "statusCode": response.statusCode,
      "message": err,
    };
  }

  Future<dynamic> signinWithEmailPassword({
    required String email,
    required String password,
    required UtilisateurProvider utilisateurProvider,
  }) async {
    // Appel à l'API pour tenter de s'authentifier
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/login',
      jsonBody: {
        "email": email,
        "password": password,
      },
      typeRequeteHttp: TypeRequeteHttp.POST,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      isLoggedIn = false;
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    // Authentification OK
    if (response.statusCode == 200) {
      afficherLogInfo(
          "L'utilisateur [${email}] s'est authentifié avec succès sous le role [${json.decode(response.body)["role"]}]");
      var body = json.decode(response.body);
      utilisateurProvider.updateUser(Utilisateur.fromJson(body));
      setValueInHardwareMemory(key: "token", value: body["token"]);
      isLoggedIn = true;
      return {
        "statusCode": 200,
        "message": null,
      };
    }
    // Authentification KO
    isLoggedIn = false;
    unsetValueInHardwareMemory(key: "token");
    afficherLogInfo("L'utilisateur [${email}] n'a pas pu s'authentifier.");
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"] ??
          "L'utilisateur n'a pas pu s'authentifier.",
    };
  }

  // Permet d'interroger l'API pour s'authentifier
  Future<dynamic> recupererConnexionDepuisToken(
    String token,
    UtilisateurProvider utilisateurProvider,
  ) async {
    // Appel à l'API pour tenter de s'authentifier
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/refresh',
      typeRequeteHttp: TypeRequeteHttp.GET,
      token: token,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      isLoggedIn = false;
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;

    // Authentification OK
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      afficherLogInfo(
          "Succès : Appel au provider pour récupération du compte à partir du token.");
      utilisateurProvider.updateUser(Utilisateur.fromJson(body));
      utilisateurProvider.utilisateur!.token = token;
      if (utilisateurProvider.estAdmin) {
        utilisateurProvider.setPerspective(Perspective.ADMIN);
      } else if (utilisateurProvider.estOrganisateur) {
        utilisateurProvider.setPerspective(Perspective.ORGANIZER);
      } else {
        utilisateurProvider.setPerspective(Perspective.PARENT);
      }
      isLoggedIn = true;
      return {
        "statusCode": 200,
        "message": "Récupération du compte : OK",
      };
    }
    // Authentification KO
    isLoggedIn = false;
    unsetValueInHardwareMemory(key: "token");
    return {
      "statusCode": response.statusCode,
      "message": "Récupération du compte : KO"
    };
  }

  // Permet d'interroger l'API pour s'authentifier
  Future<dynamic> signup(
    SignupForm signupForm,
    UtilisateurProvider utilisateurProvider,
  ) async {
    // Appel à l'API pour tenter de s'authentifier
    isLoading = true;
    ReponseAPI reponseApi = await callAPI(
      uri: '/auth/create',
      jsonBody: signupForm.toJson(),
      typeRequeteHttp: TypeRequeteHttp.POST,
    );
    isLoading = false;

    // Cas où la connexion avec l'API n'a pas pu être établie
    if (!reponseApi.connexionAPIEtablie) {
      isLoggedIn = false;
      return {
        "statusCode": ReponseAPI.STATUS_CODE_API_KO,
        "message": ReponseAPI.MESSAGE_ERREUR_API_KO,
      };
    }

    http.Response response = reponseApi.response as http.Response;
    // Authentification OK
    if (response.statusCode == 201) {
      afficherLogInfo(
          "Le compte de l'utilisateur [${signupForm.prenom} ${signupForm.nom}] a été créé avec succès.");
      return {
        "statusCode": response.statusCode,
        "message":
            "Le compte a bien été créé. Vous allez recevoir un email afin de vérifier votre compte.",
      };
    }
    // Authentification KO
    afficherLogInfo(
        "La tentative de création d'un compte pour [${signupForm.prenom} ${signupForm.nom}] a échoué.");
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"] ??
          "La tentative de connexion a échoué.",
    };
  }

  // Permet de se déconnecter
  void logout(context, UtilisateurProvider utilisateurProvider) {
    utilisateurProvider.updateUser(null);
    isLoggedIn = false;
    unsetValueInHardwareMemory(key: "token");
    naviguerVersPage(context, LoginView.routeURL);
  }
}
