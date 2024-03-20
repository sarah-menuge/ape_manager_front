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
    this.quantiteMax = -1,
    this.prix = 0.0,
    this.description = "",
  });

  Article.bidon() {
    id = 1;
    nom = "Boîte de chocolats !!!";
    quantiteMax = 100;
    prix = 10.99;
    description =
        "Une boîte de chocolat de 500g remplie de pleins de bonnes choses";
  }

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

  Map<String, dynamic> toJson(int? eventId) {
    Map<String, dynamic> json = {};

    if (eventId != null) json.addAll({"event": eventId});

    json.addAll({
      "name": nom,
      "maxQuantity": quantiteMax,
      "price": prix,
      "description": description,
      "category": ""
    });

    return json;
  }

  @override
  String toString() {
    return nom;
  }

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Nom") return nom;
    if (nom_colonne == "Qté.\nmax") {
      return quantiteMax == -1 ? "-" : quantiteMax;
    }
    if (nom_colonne == "Prix") return "${prix.toStringAsFixed(2)} €";
    if (nom_colonne == "Desc") return description;
  }

  @override
  List<String> intitulesHeader() {
    return ["Nom", "Qté.\nmax", "Prix", "Desc"];
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
