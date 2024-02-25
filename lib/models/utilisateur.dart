enum RoleUtilisateur { parent, organisateur, administrateur }

class Utilisateur {
  late String nom;
  late String prenom;
  late RoleUtilisateur role;
  late String token;

  Utilisateur.fromJson(Map<String, dynamic> json){
    nom = json["nom"];
    prenom = json["prenom"];
    token = json["token"];

    if(json["role"] == "PARENT") {
      role = RoleUtilisateur.parent;
    } else if(json["role"] == "ORGANISATEUR") {
      role = RoleUtilisateur.organisateur;
    }
    else if (json["role"] == "ADMINISTRATEUR") {
      role = RoleUtilisateur.administrateur;
    }
    else {
      role = RoleUtilisateur.parent;
    }
  }

  @override
  String toString(){
    return "$prenom $nom - $role";
  }
}