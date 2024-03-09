import 'dart:convert';
import 'dart:io';

import 'package:ape_manager_front/utils/logs.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:universal_html/html.dart' as html;

import '../proprietes/constantes.dart';

class ReponseAPI {
  static const int STATUS_CODE_API_KO = 503;
  static const String MESSAGE_ERREUR_API_KO =
      "La connexion avec l'API a échoué.";

  bool connexionAPIEtablie;
  http.Response? response;

  ReponseAPI.connexionOk({
    required this.response,
    this.connexionAPIEtablie = true,
  });

  ReponseAPI.connexionKO({
    this.connexionAPIEtablie = false,
  });
}

enum TypeRequeteHttp { GET, POST, PUT, DELETE }

/// Méthode permettant d'interroger l'API en fonction de l'environnement de test / production
Future<ReponseAPI> callAPI({
  required String uri,
  required TypeRequeteHttp typeRequeteHttp,
  Object? jsonBody,
  String? token,
  int timeoutSec = 3,
}) async {
  var isPhysicalDevice;
  var isNavigator;
  // Récupération des informations relatives au type d'appareil
  await DeviceInfoPlugin().deviceInfo.then((value) {
    isPhysicalDevice = value.data['isPhysicalDevice'];
    isNavigator = html.window.navigator.userAgent.contains('Mozilla') &&
        html.window.navigator.userAgent.contains('Gecko');
  });

  // Recherche l'URL de l'API
  String rootURL = URL_API;
  if (PROD == "true") {
    rootURL = URL_API;
  } else if (isNavigator == true) {
    rootURL = "http://localhost:8080";
  } else if (isPhysicalDevice == true) {
    rootURL = "http://localhost:8080";
  } else {
    rootURL = "http://10.0.2.2:8080";
  }

  // Appel à la fonction relative au verbe HTTP utilisé
  if (typeRequeteHttp == TypeRequeteHttp.POST) {
    return await _tentativeAppelAPIPOST(
      rootURL: rootURL,
      uri: uri,
      jsonBody: jsonBody as Object,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  if (typeRequeteHttp == TypeRequeteHttp.PUT) {
    return await _tentativeAppelAPIPUT(
      rootURL: rootURL,
      uri: uri,
      jsonBody: jsonBody as Object,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  if (typeRequeteHttp == TypeRequeteHttp.DELETE) {
    return await _tentativeAppelAPIDELETE(
      rootURL: rootURL,
      uri: uri,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  return await _tentativeAppelAPIGET(
    rootURL: rootURL,
    uri: uri,
    timeoutSec: timeoutSec,
    token: token,
  );
}

// Méthode privée permettant d'appeler l'API depuis un URL particulier, en méthode POST
Future<ReponseAPI> _tentativeAppelAPIPOST({
  required String rootURL,
  required String uri,
  required Object jsonBody,
  required int timeoutSec,
  String? token,
}) async {
  try {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    if (token != null) {
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }

    ReponseAPI repAPI = ReponseAPI.connexionOk(
      response: await http
          .post(
            Uri.parse('$rootURL$uri'),
            headers: headers,
            body: json.encode(jsonBody),
          )
          .timeout(
            Duration(seconds: timeoutSec),
          ),
    );
    return repAPI;
  } catch (e) {
    afficherLogCritical("La tentative de connexion à l'API a échoué.");
    return ReponseAPI.connexionKO();
  }
}

// Méthode privée permettant d'appeler l'API depuis un URL particulier, en méthode GET
Future<ReponseAPI> _tentativeAppelAPIGET({
  required String rootURL,
  required String uri,
  required int timeoutSec,
  String? token,
}) async {
  try {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});

    ReponseAPI repAPI = ReponseAPI.connexionOk(
      response: await http
          .get(
            Uri.parse('$rootURL$uri'),
            headers: headers,
          )
          .timeout(
            Duration(seconds: timeoutSec),
          ),
    );
    return repAPI;
  } catch (e) {
    return ReponseAPI.connexionKO();
  }
}

// Méthode privée permettant d'appeler l'API depuis un URL particulier, en méthode PUT
Future<ReponseAPI> _tentativeAppelAPIPUT({
  required String rootURL,
  required String uri,
  required Object jsonBody,
  required int timeoutSec,
  String? token,
}) async {
  try {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});

    ReponseAPI repAPI = ReponseAPI.connexionOk(
      response: await http
          .put(
            Uri.parse('$rootURL$uri'),
            headers: headers,
            body: json.encode(jsonBody),
          )
          .timeout(
            Duration(seconds: timeoutSec),
          ),
    );
    return repAPI;
  } catch (e) {
    return ReponseAPI.connexionKO();
  }
}

// Méthode privée permettant d'appeler l'API depuis un URL particulier, en méthode PUT
Future<ReponseAPI> _tentativeAppelAPIDELETE({
  required String rootURL,
  required String uri,
  required int timeoutSec,
  String? token,
}) async {
  try {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});

    ReponseAPI repAPI = ReponseAPI.connexionOk(
      response: await http
          .delete(
            Uri.parse('$rootURL$uri'),
            headers: headers,
          )
          .timeout(
            Duration(seconds: timeoutSec),
          ),
    );
    return repAPI;
  } catch (e) {
    return ReponseAPI.connexionKO();
  }
}
