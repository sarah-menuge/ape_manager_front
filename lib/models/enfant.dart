class Enfant {
  late int id;
  late String nom;
  late String prenom;
  late String classe;

  Enfant({this.id = -1, this.nom = "", this.prenom = "", this.classe = ""});

  Enfant.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
    } catch (e) {
      id = -1;
    }
    nom = json["nom"];
    prenom = json["prenom"];
    classe = json["classe"];
  }

  @override
  String toString() {
    return "$prenom $nom ($classe)";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nom": nom,
      "prenom": prenom,
      "classe": classe,
    };
  }
}
