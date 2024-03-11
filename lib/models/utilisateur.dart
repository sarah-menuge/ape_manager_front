import 'package:flutter/material.dart';

import 'enfant.dart';

enum RoleUtilisateur { parent, organisateur, administrateur, prof, inactif }

class Utilisateur {
  late int id;
  late String nom;
  late String prenom;
  late String email;
  late String telephone;
  late RoleUtilisateur role;
  late String token;

  List<Enfant> enfants = [];

  Utilisateur.copie(Utilisateur other) {
    id = other.id;
    nom = other.nom;
    prenom = other.prenom;
    email = other.email;
    telephone = other.telephone;
    role = other.role;
    token = other.token;
  }

  Utilisateur.fromJson(Map<String, dynamic> json) {
    id = -1;
    nom = json["surname"];
    prenom = json["firstname"];
    email = json["email"];

    try {
      telephone = json["phone"];
    } catch (e) {
      telephone = "";
    }

    try {
      token = json["token"];
    } catch (e) {
      token = "";
    }

    if (json["role"] == "PARENT") {
      role = RoleUtilisateur.parent;
    } else if (json["role"] == "ORGANIZER") {
      role = RoleUtilisateur.organisateur;
    } else if (json["role"] == "ADMIN") {
      role = RoleUtilisateur.administrateur;
    } else if (json["role"] == "PROF") {
      role = RoleUtilisateur.prof;
    } else {
      role = RoleUtilisateur.inactif;
    }
  }

  void setEnfants(json) {
    enfants = (json as List<dynamic>).map((e) => Enfant.fromJson(e)).toList();
  }

  Map<String, dynamic> toJsonModifDetails() {
    return {
      "email": email,
      "surname": nom,
      "firstname": prenom,
      "phone": telephone,
    };
  }

  TextEditingController getNomController() => TextEditingController(text: nom);

  TextEditingController getPrenomController() =>
      TextEditingController(text: prenom);

  TextEditingController getEmailController() =>
      TextEditingController(text: email);

  TextEditingController getTelephoneController() =>
      TextEditingController(text: telephone);

  @override
  String toString() {
    return "$prenom $nom";
  }

  bool equals(Object o) {
    if (identical(this, o)) return true;
    if (o.runtimeType != this.runtimeType) return false;
    Utilisateur other = o as Utilisateur;
    return id == other.id &&
        nom == other.nom &&
        prenom == other.prenom &&
        email == other.email &&
        telephone == other.telephone;
  }
}
