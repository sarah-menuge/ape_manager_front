enum RoleUtilisateur { parent, organisateur, administrateur }

class Utilisateur {
  String nom;
  String prenom;
  late RoleUtilisateur role;
  String token;

  Utilisateur({required this.nom, required this.prenom, required String role, required this.token}){
    if(role == "PARENT") {
      this.role = RoleUtilisateur.parent;
    } else if(role == "ORGANISATEUR") {
      this.role = RoleUtilisateur.organisateur;
    }
    else if (role == "ADMINISTRATEUR") {
      this.role = RoleUtilisateur.administrateur;
    }
    else {
      this.role = RoleUtilisateur.parent;
    }
  }
}