import 'dart:convert';
import 'dart:io';

import 'package:ape_manager_front/utils/logs.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
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

enum TypeRequeteHttp { GET, POST, PUT, DELETE, PATCH }

/// Méthode permettant d'interroger l'API en fonction de l'environnement de test / production
Future<ReponseAPI> callAPI({
  required String uri,
  required TypeRequeteHttp typeRequeteHttp,
  Object? jsonBody,
  int timeoutSec = 3,
  String? token,
}) async {
  // Récupération des informations relatives au type d'appareil
  dynamic isPhysicalDevice;
  dynamic isNavigator;
  await DeviceInfoPlugin().deviceInfo.then((value) {
    isPhysicalDevice = value.data['isPhysicalDevice'];
    isNavigator = html.window.navigator.userAgent.contains('Mozilla') &&
        html.window.navigator.userAgent.contains('Gecko');
  });

  // Recherche quel URL utiliser pour contacter l'API
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
    return await _tentativeAppelAPI(
      methodeHttp: http.post,
      rootUrl: rootURL,
      uri: uri,
      jsonBody: jsonBody as Object,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  if (typeRequeteHttp == TypeRequeteHttp.PUT) {
    return await _tentativeAppelAPI(
      methodeHttp: http.put,
      rootUrl: rootURL,
      uri: uri,
      jsonBody: jsonBody != null ? jsonBody : null,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  if (typeRequeteHttp == TypeRequeteHttp.DELETE) {
    return await _tentativeAppelAPI(
      methodeHttp: http.delete,
      rootUrl: rootURL,
      uri: uri,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  if (typeRequeteHttp == TypeRequeteHttp.PATCH) {
    return await _tentativeAppelAPI(
      methodeHttp: http.patch,
      rootUrl: rootURL,
      uri: uri,
      timeoutSec: timeoutSec,
      token: token,
    );
  }
  return await _tentativeAppelAPI(
    methodeHttp: http.get,
    rootUrl: rootURL,
    uri: uri,
    timeoutSec: timeoutSec,
    token: token,
  );
}

// Méthode privée permettant d'appeler l'API
Future<ReponseAPI> _tentativeAppelAPI({
  required Function methodeHttp,
  required String rootUrl,
  required String uri,
  required int timeoutSec,
  String? token,
  Object? jsonBody,
}) async {
  //try {
  // Gestion de l'URL de l'API à appeler
  Uri URL = Uri.parse('$rootUrl$uri');

  // Gestion des headers
  var HEADERS = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  if (token != null) {
    HEADERS.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
  }
  if (NGROK == "true") {
    HEADERS.addAll({"ngrok-skip-browser-warning": '69420'});
  }
  
  // Appel à l'API
  try {
    if (jsonBody != null) {
      http.Response reponse = await methodeHttp(
        URL,
        headers: HEADERS,
        body: json.encode(jsonBody),
      ).timeout(Duration(seconds: timeoutSec));
      return ReponseAPI.connexionOk(response: reponse);
    } else {
      http.Response reponse = await methodeHttp(
        URL,
        headers: HEADERS,
      ).timeout(Duration(seconds: timeoutSec));
      return ReponseAPI.connexionOk(response: reponse);
    }
  } catch (e) {
    afficherLogCritical("La tentative de connexion à l'API a échoué.");
    return ReponseAPI.connexionKO();
  }
}
