import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';

class Panier {
  List<Article> articles = [];
  int idEvenement = -1;
  int idLieuRetrait = -1;

  Panier({this.idEvenement = -1, this.idLieuRetrait = -1});

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

  Map<String, dynamic> toJson() {
    List<Map<String, int>> lignesCommande = [];

    Map<int, int> occurrences = {};
    for (Article article in articles) {
      if (occurrences.containsKey(article.id)) {
        occurrences.update(article.id, (value) => value + 1);
      } else {
        occurrences[article.id] = 1;
      }
    }

    occurrences.forEach((key, value) {
      lignesCommande.add({"item_id": key, "quantity": value});
    });

    return {
      "eventId": idEvenement,
      "pickUpPlaceId": idLieuRetrait != -1 ? idLieuRetrait : null,
      "orderLines": lignesCommande,
      "childId": null,
    };
  }
}
