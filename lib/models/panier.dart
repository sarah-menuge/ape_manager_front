import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';

class Panier {
  List<Article> articles = [];

  Panier();

  Panier.fromLignesCommande(List<LigneCommande> lignesCommande) {
    for (LigneCommande ligneCommande in lignesCommande) {
      for (int i = 0; i < ligneCommande.quantite; i++) {
        articles.add(ligneCommande.article);
      }
    }
  }

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

  double get prixTotal => articles.fold(
        0,
        (double prixTotal, Article article) => prixTotal + article.prix,
      );

  @override
  String toString() {
    return articles.toString();
  }
}
