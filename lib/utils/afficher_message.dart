import 'package:flutter/material.dart';

afficherMessageSucces({required BuildContext context, required String message, int duree = 6}){
  _afficherMessage(context: context, message: message, duree: duree, couleur: Colors.green);
}

afficherMessageErreur({required BuildContext context, required String message, int duree = 6}){
  _afficherMessage(context: context, message: message, duree: duree, couleur: Colors.red);
}

afficherMessageInfo({required BuildContext context, required String message, int duree = 6}){
  _afficherMessage(context: context, message: message, duree: duree, couleur: Colors.blue);
}

_afficherMessage({required BuildContext context, required String message, required int duree, required MaterialColor couleur}){
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(label: 'X', onPressed: scaffold.hideCurrentSnackBar),
      backgroundColor: couleur,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds : duree),
      elevation: 5,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 55,
          left: 10,
          right: 10),
    ),
  );
}