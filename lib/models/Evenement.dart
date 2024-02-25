import 'package:ape_manager_front/models/Article.dart';

class Evenement {
  String titre;
  String description;
  String statut;
  List<Article> liste_articles;

  Evenement({
    required this.titre,
    required this.description,
    required this.statut,
    required this.liste_articles,
  });
}
