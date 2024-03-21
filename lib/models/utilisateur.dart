import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/donnee_tableau.dart';
import 'package:flutter/material.dart';

import 'enfant.dart';

enum RoleUtilisateur { parent, organisateur, administrateur, prof, inactif }

class Utilisateur extends DonneeTableau {
  late int id;
  late String nom;
  late String prenom;
  late String email;
  late String telephone;
  late RoleUtilisateur role;
  late String token;
  bool est_membre = false;

  List<Enfant> enfants = [];
  List<Commande> commandes = [];

  Utilisateur();

  Utilisateur.copie(Utilisateur other) {
    id = other.id;
    nom = other.nom;
    prenom = other.prenom;
    // est_membre = other.est_membre;
    email = other.email;
    telephone = other.telephone;
    role = other.role;
    token = other.token;
  }

  Utilisateur.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
    } catch (e) {
      id = -1;
    }
    nom = json["surname"];
    prenom = json["firstname"];
    email = json["email"];
    // est_membre = json["member"];

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

  Map<String, dynamic> toJsonModifAdmin() {
    return {
      "email": email,
      "surname": nom,
      "firstname": prenom,
      "phone": telephone,
      "role": roleAPI(role),
      "member": est_membre,
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

  String roleToString(RoleUtilisateur role) {
    if (role == RoleUtilisateur.organisateur) return "Organisateur";
    if (role == RoleUtilisateur.administrateur) return "Administrateur";
    if (role == RoleUtilisateur.parent) return "Parent";
    if (role == RoleUtilisateur.prof) return "Enseignant";
    return "Inactif";
  }

  RoleUtilisateur stringToRole(String role) {
    if (role == "Organisateur") return RoleUtilisateur.organisateur;
    if (role == "Administrateur") return RoleUtilisateur.administrateur;
    if (role == "Parent") return RoleUtilisateur.parent;
    if (role == "Enseignant") return RoleUtilisateur.prof;
    return RoleUtilisateur.inactif;
  }

  String roleAPI(RoleUtilisateur role) {
    if (role == RoleUtilisateur.organisateur) return "ORGANIZER";
    if (role == RoleUtilisateur.administrateur) return "ADMIN";
    if (role == RoleUtilisateur.parent) return "PARENT";
    if (role == RoleUtilisateur.prof) return "PROF";
    if (role == RoleUtilisateur.inactif) return "INACTIVE";
    return "UNDEFINED";
  }

  List<String> roles() {
    return [
      "Administrateur",
      "Organisateur",
      "Enseignant",
      "Parent",
      "Inactif"
    ];
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

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Nom") return nom;
    if (nom_colonne == "Prénom") return prenom;
    if (nom_colonne == "Email") return email;
    if (nom_colonne == "Téléphone") return telephone;
    if (nom_colonne == "Rôle") return roleToString(role);
    if (nom_colonne == "Membre CA ?") return est_membre;
  }

  @override
  List<String> intitulesHeader() {
    return [
      "Nom",
      "Prénom",
      "Rôle",
    ];
  }

  @override
  Map<String, dynamic> pourTableau() {
    return {
      "Nom": nom,
      "Prénom": prenom,
      "Email": email,
      "Téléphone": telephone,
      "Rôle": role,
      "Membre CA ?": est_membre,
    };
  }
}
