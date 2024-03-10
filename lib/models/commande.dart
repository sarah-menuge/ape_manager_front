import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';

enum StatutCommande {
  VALIDEE,
  ANNULEE,
  A_RETIRER,
  RETIREE,
  TERMINE,
  NON_DEFINI
}

class Commande {
  late int id;
  late bool estPaye;
  late DateTime dateRetrait;
  late String lieuRetrait;
  late StatutCommande statut;
  late String libelleEvenement;
  List<Article> listeArticles = [];
  List<LigneCommande> listeLigneCommandes = [];

  Commande({
    required this.id,
    required this.estPaye,
    required this.dateRetrait,
    required this.lieuRetrait,
    required this.statut,
    required this.libelleEvenement,
  }) {
    Article article = Article(
        id: 1,
        nom: "Boîte de chocolat",
        quantiteMax: 100,
        prix: 10.99,
        description:
            "Une boîte de chocolat de 500g remplie de pleins de bonnes choses",
        categorie: "Alimentaire");
    listeArticles = [article];
    listeLigneCommandes = [
      LigneCommande(id: id, quantite: 3, article: article, commande: this)
    ];
  }

  Commande.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    estPaye = json["estPaye"];
    dateRetrait = DateTime.parse(json["date_retrait"]);
    lieuRetrait = json["lieu_retrait"];
    libelleEvenement = json["libelle_evenement"];
    listeArticles = json["listeArticles"];
    try {
      if (json["statut"] == "VALIDEE") {
        statut = StatutCommande.VALIDEE;
      } else if (json["statut"] == "ANNULEE") {
        statut = StatutCommande.ANNULEE;
      } else if (json["statut"] == "A_RETIRER") {
        statut = StatutCommande.A_RETIRER;
      } else if (json["statut"] == "RETIREE") {
        statut = StatutCommande.RETIREE;
      } else if (json["statut"] == "TERMINE") {
        statut = StatutCommande.TERMINE;
      } else {
        statut = StatutCommande.NON_DEFINI;
      }
    } catch (e) {
      statut = StatutCommande.NON_DEFINI;
    }
  }

  String getStatut() {
    if (statut == StatutCommande.VALIDEE && estPaye) return "Validé et payé";
    if (statut == StatutCommande.VALIDEE && !estPaye)
      return "Validé et non payé";
    if (statut == StatutCommande.ANNULEE) return "Annulée";
    if (statut == StatutCommande.A_RETIRER) return "À retirer";
    if (statut == StatutCommande.RETIREE) return "Retirée";
    if (statut == StatutCommande.TERMINE) return "Terminée";
    if (statut == StatutCommande.NON_DEFINI) return "Non défini";
    return "Non défini";
  }
}
