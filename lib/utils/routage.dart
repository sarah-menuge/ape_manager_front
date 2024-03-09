import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void naviguerVersPage(BuildContext context, String routeURL) {
  afficherLogInfo("Navigation vers la page $routeURL.");
  try {
    context.go(routeURL);
  } catch (e) {
    afficherLogCritical("La page '$routeURL' n'a pas été trouvée.");
  }
}

void revenirEnArriere(BuildContext context, {String routeURL = ""}) {
  try {
    if (routeURL != "") {
      afficherLogInfo("Retour arrière vers la page $routeURL.");
      context.go(routeURL);
    } else {
      afficherLogInfo("Popup quittée.");
      Navigator.pop(context);
    }
  } catch (e) {
    afficherLogCritical(
        "Le retour arrière vers la page '$routeURL' n'a pas pu être effectué.");
  }
}
