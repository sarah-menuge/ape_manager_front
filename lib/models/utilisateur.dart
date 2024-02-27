import 'package:flutter/material.dart';

import 'enfant.dart';

enum RoleUtilisateur { parent, organisateur, administrateur }

class Utilisateur {
  late String nom;
  late String prenom;
  late String email;
  late String telephone;
  late RoleUtilisateur role;
  late String token;

  List<Enfant> enfants = [];

  Utilisateur.fromJson(Map<String, dynamic> json) {
    nom = json["nom"];
    prenom = json["prenom"];
    token = json["token"];
    email = "";
    telephone = "";

    if (json["role"] == "PARENT") {
      role = RoleUtilisateur.parent;
    } else if (json["role"] == "ORGANISATEUR") {
      role = RoleUtilisateur.organisateur;
    } else if (json["role"] == "ADMINISTRATEUR") {
      role = RoleUtilisateur.administrateur;
    } else {
      role = RoleUtilisateur.parent;
    }

    enfants
        .add(Enfant(id: 1, nom: 'Pepin', prenom: 'Alexandre', classe: 'CM1'));
    enfants.add(Enfant(id: 2, nom: 'Menuge', prenom: 'Sarah', classe: 'CM0'));
  }

  Utilisateur.copie(Utilisateur other) {
    nom = other.nom;
    prenom = other.prenom;
    email = other.email;
    telephone = other.telephone;
    role = other.role;
    token = other.token;
  }

  @override
  String toString() {
    return "$prenom $nom - $role";
  }

  TextEditingController getNomController() => TextEditingController(text: nom);

  TextEditingController getPrenomController() =>
      TextEditingController(text: prenom);

  TextEditingController getEmailController() =>
      TextEditingController(text: email);

  TextEditingController getTelephoneController() =>
      TextEditingController(text: telephone);
}
