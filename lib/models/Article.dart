class Article {
  late int id;
  late String nom;
  late int quantiteMax;
  late double prix;
  late String description;
  late String categorie;

  Article({
    required this.id,
    required this.nom,
    required this.quantiteMax,
    required this.prix,
    required this.description,
    required this.categorie,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['name'];
    quantiteMax = json['maxQuantity'];
    prix = json['price'];
    description = json['description'];
    categorie = json['category'];
  }

  @override
  String toString() {
    return nom;
  }
}
