import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../forms/login_form.dart';
import '../forms/signup_form.dart';
import '../models/utilisateur.dart';
import '../utils/stockage_hardware.dart';
import '../views/login/login_view.dart';
import 'call_api.dart';

class AuthentificationProvider with ChangeNotifier {
  bool isLoading = false;
  bool isLoggedIn = false;

  // Permet d'interroger l'API pour s'authentifier
  Future<dynamic> signin(
      LoginForm loginForm, UtilisateurProvider utilisateurProvider) async {
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
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  // Permet d'interroger l'API pour s'authentifier
  Future<dynamic> signup(
      SignupForm signupForm, UtilisateurProvider utilisateurProvider) async {
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
      return signin(
        LoginForm(email: signupForm.email, password: signupForm.password),
        utilisateurProvider,
      );
    }
    // Authentification KO
    return {
      "statusCode": response.statusCode,
      "message": json.decode(response.body)["message"],
    };
  }

  // Permet de se déconnecter
  void logout(context, UtilisateurProvider utilisateurProvider) {
    utilisateurProvider.updateUser(null);
    isLoggedIn = false;
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }

// Pas utilisé pour le moment
/*Future<void> initAuth() async {
    try {
      String? oldToken = getValueInHardwareMemory(key: "token");
      if (oldToken == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
        token = oldToken;
      }
    } catch (e) {
      rethrow;
    }
  }*/
}
