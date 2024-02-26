class Article {
  int id;
  String nom;
  int quantiteMax;
  double prix;
  String description;
  String categorie;

  Article({
    required this.id,
    required this.nom,
    required this.quantiteMax,
    required this.prix,
    required this.description,
    required this.categorie,
  });

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nom = json['nom'],
        quantiteMax = json['quantiteMax'],
        prix = json['prix'],
        description = json['description'],
        categorie = json['categorie'];
}
