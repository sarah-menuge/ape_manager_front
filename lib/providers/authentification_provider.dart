import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import '../forms/login_form.dart';
import '../proprietes/constantes.dart';
import '../views/login/login_view.dart';

class AuthentificationProvider with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? token;
  bool isLoading = false;
  bool isLoggedIn = false;

  // Pas utilisé pour le moment
  Future<void> initAuth() async {
    try {
      String? oldToken = await storage.read(key: "token");
      if (oldToken == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
        token = oldToken;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Permet d'interroger l'API pour s'athentifier
  Future<dynamic> signin(LoginForm loginForm) async {
    try {
      // Appel à l'API pour tenter de s'authentifier
      isLoading = true;
      http.Response response = await http.post(
        Uri.parse('$HOST_URL/auth/login'),
        headers: {'Content-type': 'application/json'},
        body: json.encode(loginForm.toJson()),
      );
      isLoading = false;
      // Authentification OK
      if (response.statusCode == 200) {
        token = json.decode(response.body);
        storage.write(key: "token", value: token);
        isLoggedIn = true;
        return {
          "statusCode": 200,
          "message": null,
          "token": token,
        };
      }
      // Authentification KO
      return {
        "statusCode": response.statusCode,
        "message": json.decode(response.body)["message"],
        "token": null,
      };
    } catch (e) {
      isLoading = false;
      isLoggedIn = false;
      rethrow;
    }
  }

  // Permet d'interroger l'API pour se déconnecter
  void logout(context) {
    token = null;
    isLoggedIn = false;
    print("LOGOUT");
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
