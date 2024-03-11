import 'package:ape_manager_front/models/utilisateur.dart';

class Organisateur {
  late int id;
  late String nom;
  late String prenom;
  late String email;
  late String telephone;
  late RoleUtilisateur role;
  late bool estMembre;

  Organisateur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.role,
    required this.estMembre,
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

  @override
  String toString() {
    return "$prenom $nom ($email:$id)";
  }
}
