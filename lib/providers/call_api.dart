import 'dart:convert';

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

/// Méthode permettant d'interroger l'API en fonction de l'environnement de test / production
Future<ReponseAPI> callAPI({
  required String uri,
  required Object jsonBody,
  int timeoutSec = 3,
}) async {
  var isPhysicalDevice;
  var isNavigator;
  await DeviceInfoPlugin().deviceInfo.then((value) {
    isPhysicalDevice = value.data['isPhysicalDevice'];
    isNavigator = html.window.navigator.userAgent.contains('Mozilla') &&
        html.window.navigator.userAgent.contains('Gecko');
  });
  print("is physical device : $isPhysicalDevice");
  print("is navigator : $isNavigator");

  String rootURL = URL_API;
  if (PROD == "true") {
    print("in prod.");
    rootURL = URL_API;
  } else if (isNavigator == true) {
    print("is navigator.");
    rootURL = "http://localhost:8080";
  } else if (isPhysicalDevice == true) {
    print("is smartphone.");
    rootURL = "http://localhost:8080";
  } else {
    print("is emulator.");
    rootURL = "http://10.0.2.2:8080";
  }
  return await _tentativeAppelAPIPOST(
    rootURL: rootURL,
    uri: uri,
    jsonBody: jsonBody,
    timeoutSec: timeoutSec,
  );
}

// Méthode privée permettant d'appeler l'API depuis un URL particulier, en méthode POST
Future<ReponseAPI> _tentativeAppelAPIPOST({
  required String rootURL,
  required String uri,
  required Object jsonBody,
  required int timeoutSec,
}) async {
  //try {
  ReponseAPI repAPI = ReponseAPI.connexionOk(
    response: await http
        .post(
          Uri.parse('$rootURL$uri'),
          headers: {
            'Content-type': 'application/json',
            //'Access-Control-Allow-Origin': "*",
            //'Accept': '*/*',
            //'Access-Control-Allow-Methods':
            //    'POST, GET, OPTIONS, PUT, DELETE, HEAD',
            //'Access-Control-Allow-Headers':
            //    'Origin, X-Requested-With, Content-Type, Accept'
          },
          body: json.encode(jsonBody),
        )
        .timeout(
          Duration(seconds: timeoutSec),
        ),
  );
  return repAPI;
  /*} catch (e) {
    return ReponseAPI.connexionKO();
  }*/
}
