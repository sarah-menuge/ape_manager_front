import 'donnee_tableau.dart';

class Article extends DonneeTableau {
  late int id;
  late String nom;
  late int quantiteMax;
  late double prix;
  late String description;

  Article({
    this.id = -1,
    this.nom = "",
    this.quantiteMax = 0,
    this.prix = 0.0,
    this.description = "",
  });

  Article.copie(Article other) {
    id = other.id;
    nom = other.nom;
    quantiteMax = other.quantiteMax;
    prix = other.prix;
    description = other.description;
  }

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['name'];
    quantiteMax = json['maxQuantity'];
    prix = json['price'];
    description = json['description'];
  }

  @override
  String toString() {
    return nom;
  }

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Nom") return nom;
    if (nom_colonne == "max") return quantiteMax;
    if (nom_colonne == "Prix") return prix;
    if (nom_colonne == "Desc") return description;
  }

  @override
  List<String> intitulesHeader() {
    return ["Nom", "Max", "Prix", "Desc"];
  }

  @override
  Map<String, dynamic> pourTableau() {
    return {
      "Nom": nom,
      "Max": quantiteMax,
      "Prix": prix,
      "Desc": description,
    };
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Article) return false;
    return (other as Article).id == id;
  }
}
