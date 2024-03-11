import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';

enum StatutCommande {
  VALIDEE,
  ANNULEE,
  A_RETIRER,
  RETIREE,
  CLOTUREE,
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
    );
    listeArticles = [article];
    listeLigneCommandes = [
      LigneCommande(id: id, quantite: 3, article: article)
    ];
  }

  Commande.copie(Commande other) {
    id = other.id;
    estPaye = other.estPaye;
    dateRetrait = other.dateRetrait;
    lieuRetrait = other.lieuRetrait;
    statut = other.statut;
    libelleEvenement = other.libelleEvenement;
    for (Article article in other.listeArticles) {
      listeArticles.add(Article.copie(article));
    }
    for (LigneCommande ligneCommande in other.listeLigneCommandes) {
      listeLigneCommandes.add(LigneCommande.copie(ligneCommande));
    }
  }

  Commande.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    estPaye = json["isPaid"] == "true" ? true : false;
    dateRetrait = DateTime.parse(json["pickUpDate"]);
    lieuRetrait = json["pickUpPlace"];

    try {
      libelleEvenement = json["event"];
    } catch (e) {
      libelleEvenement = "?";
    }

    // listeArticles = json["listeArticles"];
    // listeLigneCommandes =

    try {
      if (json["status"] == "VALIDATED") {
        statut = StatutCommande.VALIDEE;
      } else if (json["status"] == "CANCELED") {
        statut = StatutCommande.ANNULEE;
      } else if (json["status"] == "TO_COLLECT") {
        statut = StatutCommande.A_RETIRER;
      } else if (json["status"] == "COLLECTED") {
        statut = StatutCommande.RETIREE;
      } else if (json["status"] == "CLOSED") {
        statut = StatutCommande.CLOTUREE;
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
    if (statut == StatutCommande.CLOTUREE) return "Clôturée";
    if (statut == StatutCommande.NON_DEFINI) return "Non défini";
    return "Non défini";
  }
}
