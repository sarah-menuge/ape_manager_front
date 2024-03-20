import 'package:ape_manager_front/models/article.dart';

class LigneCommande {
  late int id;
  late int quantite;
  late Article article;

  LigneCommande({
    required this.id,
    required this.quantite,
    required this.article,
  });

  LigneCommande.copie(LigneCommande other) {
    id = other.id;
    quantite = other.quantite;
    article = Article.copie(other.article);
  }

  LigneCommande.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quantite = json["quantity"];
    article = Article.fromJson(json["item"]);
  }
}
