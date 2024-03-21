import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/models/utilisateur.dart';

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
  late String libelleEvenement;
  late int nombreArticles;
  late double prixTotal;
  late DateTime dateCreation;
  late DateTime? dateRetrait;
  late LieuRetrait lieuRetrait;
  late bool estPaye;
  late StatutCommande statut;
  List<Article> listeArticles = [];
  List<LigneCommande> listeLigneCommandes = [];
  late Utilisateur utilisateur;

  Commande({
    required this.id,
    required this.libelleEvenement,
    required this.nombreArticles,
    required this.prixTotal,
    required this.dateCreation,
    required this.dateRetrait,
    required this.lieuRetrait,
    required this.estPaye,
    required this.statut,
    required this.listeArticles,
    required this.listeLigneCommandes,
    required this.utilisateur,
  });

  Commande.bidon(int seed) {
    id = seed;
    libelleEvenement = "Vente de chocolats";
    nombreArticles = 3;
    prixTotal = 16.66;
    dateCreation = DateTime(2024, 10, 31);
    dateRetrait = DateTime(2024, 11, 30);
    lieuRetrait = LieuRetrait(id: 1, lieu: "Face à l'école");
    estPaye = false;
    statut = StatutCommande.RETIREE;
    Article article = Article.bidon();
    listeArticles = [article];
    listeLigneCommandes = [
      LigneCommande(id: id, quantite: 3, article: article),
    ];
    utilisateur = Utilisateur();
  }

  Commande.copie(Commande other) {
    id = other.id;
    libelleEvenement = other.libelleEvenement;
    nombreArticles = other.nombreArticles;
    prixTotal = other.prixTotal;
    dateCreation = other.dateCreation;
    dateRetrait = other.dateRetrait;
    lieuRetrait = LieuRetrait.copie(other.lieuRetrait);
    estPaye = other.estPaye;
    statut = other.statut;
    utilisateur = other.utilisateur;
    for (Article article in other.listeArticles) {
      listeArticles.add(Article.copie(article));
    }
    for (LigneCommande ligneCommande in other.listeLigneCommandes) {
      listeLigneCommandes.add(LigneCommande.copie(ligneCommande));
    }
    utilisateur = other.utilisateur;
  }

  Commande.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    libelleEvenement = json["event"];
    nombreArticles = json["totalItems"];
    prixTotal = json["totalPrice"];
    utilisateur = Utilisateur.fromJson(json["user"]);
    dateCreation = DateTime.parse(json["creationDate"]);
    try {
      dateRetrait = DateTime.parse(json["pickUpDate"]);
    } catch (e) {
      dateRetrait = null;
    }
    utilisateur = Utilisateur.fromJson(json["user"]);
    lieuRetrait = LieuRetrait.fromJson(json["pickUpPlace"]);
    estPaye = json["isPaid"];
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
    listeLigneCommandes.addAll(
      (json["orderlines"] as List<dynamic>).map(
        (o) => LigneCommande.fromJson(o),
      ),
    );
  }

  String getStatut() {
    if (statut == StatutCommande.VALIDEE && estPaye) return "Payée";
    if (statut == StatutCommande.VALIDEE && !estPaye)
      return "En attente de paiement";
    if (statut == StatutCommande.ANNULEE) return "Annulée";
    if (statut == StatutCommande.A_RETIRER) return "À retirer";
    if (statut == StatutCommande.RETIREE) return "Retirée";
    if (statut == StatutCommande.CLOTUREE) return "Clôturée";
    if (statut == StatutCommande.NON_DEFINI) return "Non défini";
    return "Non défini";
  }

  String getPrixTotal() {
    return prixTotal.toStringAsFixed(2);
  }

  String getNumeroCommande() {
    return id.toString().padLeft(5, '0');
  }
}
