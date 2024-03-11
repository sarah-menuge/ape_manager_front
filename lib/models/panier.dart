import 'package:ape_manager_front/models/Article.dart';

class Panier {
  List<Article> articles = [];

  Panier();

  Panier.copie(Panier other) {
    for (Article article in other.articles) {
      articles.add(Article.copie(article));
    }
  }

  void ajouterArticle(Article article) {
    articles.add(article);
  }

  void retirerArticle(Article article) {
    articles.remove(article);
  }

  double getPrixTotal() {
    double prixTotal = 0;
    for (Article article in articles) {
      prixTotal += article.prix;
    }
    return prixTotal;
  }

  @override
  String toString() {
    return articles.toString();
  }
}
