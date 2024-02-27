class Organisateur {
  late int id;
  late String nom;
  late String prenom;
  late String email;

  Organisateur({required this.id, required this.nom, required this.prenom, required this.email});

  Organisateur.fromJson(Map<String, dynamic> json){
    id = json["id"];
    nom = json["nom"];
    prenom = json["prenom"];
    email = json["email"];
  }

  @override
  String toString(){
    return "$prenom $nom ($email:$id)";
  }
}