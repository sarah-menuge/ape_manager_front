import 'package:ape_manager_front/models/donnee_tableau.dart';

class Enfant extends DonneeTableau {
  late int id;
  late String nom;
  late String prenom;
  late String classe;

  Enfant({this.id = -1, this.nom = "", this.prenom = "", this.classe = ""});

  Enfant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nom = json["surname"];
    prenom = json["firstname"];
    classe = json["level"];
  }

  Map<String, dynamic> toJson() {
    return {
      "surname": nom,
      "firstname": prenom,
      "level": classe,
    };
  }

  @override
  String toString() {
    return "$prenom $nom ($classe)";
  }

  @override
  Map<String, dynamic> pourTableau() {
    return {
      "Nom": nom,
      "Prénom": prenom,
      "Classe": classe,
    };
  }

  @override
  List<String> intitulesHeader() {
    return ["Nom", "Prénom", "Classe"];
  }

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Nom") return nom;
    if (nom_colonne == "Prénom") return prenom;
    if (nom_colonne == "Classe") return classe;
  }
}
