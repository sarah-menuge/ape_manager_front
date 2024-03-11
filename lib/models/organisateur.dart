import 'package:ape_manager_front/models/donnee_tableau.dart';
import 'package:ape_manager_front/models/utilisateur.dart';

class Organisateur extends DonneeTableau {
  late int id;
  late String nom;
  late String prenom;
  late String email;
  late String telephone;
  late RoleUtilisateur role;
  late bool estMembre;

  Organisateur({
    this.id = -1,
    this.nom = "",
    this.prenom = "",
    this.email = "",
    this.telephone = "",
    this.role = RoleUtilisateur.parent,
    this.estMembre = false,
  });

  Organisateur.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nom = json["surname"];
    prenom = json["firstname"];
    email = json["email"];
    try {
      telephone = json["phone"];
    } catch (e) {
      telephone = "";
    }
    estMembre = json["member"] == "true" ? true : false;

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

  Map<String, dynamic> toJson() {
    return {
      "nom": nom,
      "prenom": prenom,
      "email": email,
    };
  }

  @override
  String toString() {
    return "$prenom $nom";
  }

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Nom") return nom;
    if (nom_colonne == "Prénom") return prenom;
    if (nom_colonne == "Email") return email;
  }

  @override
  List<String> intitulesHeader() {
    return ["Nom", "Prénom", "Email"];
  }

  @override
  Map<String, dynamic> pourTableau() {
    return {
      "Nom": nom,
      "Prénom": prenom,
      "Email": email,
    };
  }

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Nom") return nom;
    if (nom_colonne == "Prénom") return prenom;
    if (nom_colonne == "Email") return email;
  }

  @override
  List<String> intitulesHeader() {
    return ["Nom", "Prénom", "Email"];
  }

  @override
  Map<String, dynamic> pourTableau() {
    return {
      "Nom": nom,
      "Prénom": prenom,
      "Email": email,
    };
  }
}
