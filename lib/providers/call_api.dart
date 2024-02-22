import 'dart:convert';

import 'package:http/http.dart' as http;

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
  int timeoutSec = 1,
}) async {
  // Premier appel avec l'adresse de l'API renseignée en var d'environnement
  ReponseAPI reponseApi = await _tentativeAppelAPI(
    rootURL: URL_API,
    uri: uri,
    jsonBody: jsonBody,
    timeoutSec: timeoutSec,
  );

  // Si la connexion a été établie, on retourne la réponse obtenue
  if (reponseApi.connexionAPIEtablie) return reponseApi;

  // Si on est en prod et qu'on n'a pas réussi à contacter l'API, on s'arrête là
  if (PROD == "true") return reponseApi;

  // Si on est en phase de test, on tente de se connecter à l'API depuis localhost
  return await _tentativeAppelAPI(
    rootURL: 'http://localhost:8080',
    uri: uri,
    jsonBody: jsonBody,
    timeoutSec: timeoutSec,
  );
}

// Méthode privée permettant d'appeler l'API depuis un URL particulier
Future<ReponseAPI> _tentativeAppelAPI({
  required String rootURL,
  required String uri,
  required Object jsonBody,
  required int timeoutSec,
}) async {
  try {
    ReponseAPI repAPI = ReponseAPI.connexionOk(
      response: await http
          .post(
            Uri.parse('$rootURL$uri'),
            headers: {'Content-type': 'application/json'},
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
