import 'package:ape_manager_front/forms/reinitialisation_form.dart';
import 'package:ape_manager_front/models/enfant.dart';
import 'package:flutter/material.dart';

import '../forms/modification_mdp_form.dart';
import '../models/utilisateur.dart';

class UtilisateurProvider with ChangeNotifier {
  bool isLoading = false;

  Utilisateur? utilisateur;

  void updateUser(Utilisateur? u) {
    utilisateur = u;
    notifyListeners();
  }

  // Appel à l'API pour demander la réinitialisation du mot de passe d'un compte
  Future<dynamic> reinitialiserMotDePasse(
      ReinitialisationForm reinitForm) async {
    isLoading = true;
    print("[PROVIDER] => REINIT MDP - non pris en charge");
    isLoading = false;
    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  // Appel à l'API pour modifier le mot de passe
  Future<dynamic> modifierMotDePasse(
      ModificationMdpForm modificationMdpForm) async {
    isLoading = true;
    print("[PROVIDER] => MODIFIER MDP - non pris en charge");
    isLoading = false;
    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  Future<dynamic> modifierInformationsUtilisateur(
      Utilisateur utilisateurModifie) async {
    isLoading = true;
    print("[PROVIDER] => MODIFIER INFOS UTILISATEUR - non pris en charge");
    isLoading = false;

    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  Future<dynamic> supprimerCompte() async {
    isLoading = true;
    print("[PROVIDER] => SUPPRIMER COMPTE UTILISATEUR - non pris en charge");
    isLoading = false;

    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  Future<dynamic> ajouterEnfant(Enfant enfant) async {
    isLoading = true;
    print("[PROVIDER] => AJOUTER ENFANT - non pris en charge");
    isLoading = false;

    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  Future<dynamic> modifierEnfant(Enfant enfant) async {
    isLoading = true;
    print("[PROVIDER] => MODIFIER ENFANT - non pris en charge");
    isLoading = false;

    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }

  Future<dynamic> supprimerEnfant(Enfant enfant) async {
    isLoading = true;
    print("[PROVIDER] => SUPPRIMER ENFANT - non pris en charge");
    isLoading = false;

    return {
      "statusCode": 400,
      "message": "La fonctionnalité n'est pas prise en charge."
    };
  }
}
