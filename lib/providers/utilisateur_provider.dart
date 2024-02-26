import 'package:ape_manager_front/forms/reinitialisation_form.dart';
import 'package:flutter/material.dart';

class UtilisateurProvider with ChangeNotifier {
  bool isLoading = false;

  // Appel à l'API pour demander la réinitialisation du mot de passe d'un compte
  Future<dynamic> reinitialiserMotDePasse(ReinitialisationForm reinitForm) async {
    isLoading = false;

    isLoading = true;
  }

  // Appel à l'API pour modifier le mot de passe
  Future<dynamic> modifierMotDePasse() async {

  }
}