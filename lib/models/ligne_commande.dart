import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/commande.dart';

class LigneCommande {
  late int id;
  late int quantite;
  late Article article;
  late Commande commande;

  LigneCommande({
    required this.id,
    required this.quantite,
    required this.article,
    required this.commande,
  });

  LigneCommande.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quantite = json["quantite"];
    article = json["article"];
    commande = json["commande"];
  }
}
