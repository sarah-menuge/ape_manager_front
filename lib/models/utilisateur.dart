import 'package:flutter/material.dart';

import 'enfant.dart';

enum RoleUtilisateur { parent, organisateur, administrateur, inactif }

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
    id = json["id"];
    nom = json["nom"];
    prenom = json["prenom"];
    email = json["mail"];
    telephone = json["telephone"];
    token = json["token"];

    if (json["role"] == "PARENT") {
      role = RoleUtilisateur.parent;
    } else if (json["role"] == "ORGANISATEUR") {
      role = RoleUtilisateur.organisateur;
    } else if (json["role"] == "ADMINISTRATEUR") {
      role = RoleUtilisateur.administrateur;
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
      "nom": nom,
      "prenom": prenom,
      "telephone": telephone,
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
