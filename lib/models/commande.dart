import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:intl/intl.dart';

import 'donnee_tableau.dart';

enum StatutCommande {
  VALIDEE,
  ANNULEE,
  A_RETIRER,
  RETIREE,
  CLOTUREE,
  NON_DEFINI
}

class Commande extends DonneeTableau {
  late int id;
  late String libelleEvenement;
  late int idEvenement;
  late int nombreArticles;
  late double prixTotal;
  late DateTime dateCreation;
  late DateTime? dateRetrait;
  late LieuRetrait lieuRetrait;
  late bool estPaye;
  late String nomUtilisateur;
  late StatutCommande statut;
  List<Article> listeArticles = [];
  List<LigneCommande> listeLigneCommandes = [];
  late Utilisateur utilisateur;

  Commande() {
    id = 0;
    libelleEvenement = "";
    idEvenement = 0;
    nomUtilisateur = "";
    nombreArticles = 0;
    prixTotal = 0.0;
    dateCreation = DateTime.now();
    dateRetrait = DateTime.now();
    lieuRetrait = LieuRetrait();
    estPaye = false;
    statut = StatutCommande.NON_DEFINI;
    utilisateur = Utilisateur();
  }

  Commande.bidon(int seed) {
    id = seed;
    libelleEvenement = "Vente de chocolats";
    idEvenement = 0;
    nombreArticles = 3;
    prixTotal = 16.66;
    dateCreation = DateTime(2024, 10, 31);
    dateRetrait = DateTime(2024, 11, 30);
    lieuRetrait = LieuRetrait();
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
    idEvenement = other.idEvenement;
    nombreArticles = other.nombreArticles;
    prixTotal = other.prixTotal as double;
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
    libelleEvenement = json["eventTitle"];
    idEvenement = json["eventId"];
    nombreArticles = json["totalItems"];
    dynamic rawTotalPrice = json["totalPrice"];
    if (rawTotalPrice is int) {
      prixTotal = rawTotalPrice.toDouble();
    } else {
      prixTotal = rawTotalPrice as double;
    }
    dateCreation = DateTime.parse(json["creationDate"]);
    nomUtilisateur = json["user"]["firstname"] + " " + json["user"]["surname"];
    try {
      dateRetrait = DateTime.parse(json["pickUpDate"]);
    } catch (e) {
      dateRetrait = null;
    }
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
    utilisateur = Utilisateur.fromJson(json["user"]);
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

  String getDateCreation() {
    return DateFormat('dd/MM/yyyy').format(dateCreation);
  }

  String getDateRetrait() {
    return dateRetrait != null
        ? DateFormat('dd/MM/yyyy').format(dateRetrait!)
        : " - ";
  }

  String getUser() {
    return nomUtilisateur;
  }

  Map<String, dynamic> getDonneesTableau() {
    return {
      "Numéro": getNumeroCommande(),
      "Utilisateur": getUser(),
      "Événement": libelleEvenement,
    };
  }

  @override
  getValeur(String nom_colonne) {
    if (getDonneesTableau().containsKey(nom_colonne)) {
      return getDonneesTableau()[nom_colonne];
    }
    return "Non défini";
  }

  @override
  List<String> intitulesHeader() {
    return getDonneesTableau().keys.toList();
  }

  @override
  String toString() {
    return "Commande $id : $libelleEvenement";
  }
}
