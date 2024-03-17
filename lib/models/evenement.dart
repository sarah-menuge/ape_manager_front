import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/lieu_retrait.dart';

import 'organisateur.dart';

enum StatutEvenement {
  BROUILLON,
  A_VENIR,
  EN_COURS,
  TRAITEMENT,
  RETRAIT,
  CLOTURE,
  NON_DEFINI,
}

class Evenement {
  late int id;
  late String titre;
  late List<LieuRetrait> lieu = [];
  late DateTime dateDebut;
  late DateTime dateFin;
  late bool finPaiement;
  late String description;
  late StatutEvenement statut;
  late Organisateur proprietaire;
  late List<Organisateur> organisateurs;
  List<Article> articles = [];
  List<Commande> commandes = [];

  Evenement({
    required this.id,
    required this.titre,
    required this.lieu,
    required this.dateDebut,
    required this.dateFin,
    required this.finPaiement,
    required this.statut,
    required this.description,
    required this.proprietaire,
    required this.organisateurs,
    required this.articles,
    required this.commandes,
  });

  Evenement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    titre = json["title"];
    lieu = (json["places"] as List<dynamic>)
        .map((l) => LieuRetrait.fromJson(l))
        .toList();

    dateDebut = DateTime.parse(json["startDate"]);
    dateFin = DateTime.parse(json["endDate"]);
    finPaiement = json["endOfPayment"] == "true" ? true : false;
    description = json["description"];

    if (json["status"] == "DRAFT") {
      statut = StatutEvenement.BROUILLON;
    } else if (json["status"] == "COMING_SOON") {
      statut = StatutEvenement.A_VENIR;
    } else if (json["status"] == "IN_PROGRESS") {
      statut = StatutEvenement.EN_COURS;
    } else if (json["status"] == "IN_TREATMENT") {
      statut = StatutEvenement.TRAITEMENT;
    } else if (json["status"] == "PICK_UP") {
      statut = StatutEvenement.RETRAIT;
    } else if (json["status"] == "CLOSED") {
      statut = StatutEvenement.CLOTURE;
    } else {
      statut = StatutEvenement.NON_DEFINI;
    }

    proprietaire = Organisateur.fromJson(json["owner"]);

    organisateurs = (json["organizers"] as List<dynamic>)
        .map((e) => Organisateur.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titre": titre,
      "lieux": lieu,
      "dateDebut": dateDebut.toIso8601String(),
      "dateFin": dateFin.toIso8601String(),
      "description": description,
      "statut": statut.toString().split('.').last,
      "organisateurs": organisateurs.map((e) => e.toJson()).toList(),
    };
  }

  void setArticles(listeArticles) {
    articles = listeArticles;
  }

  void setCommandes(listeCommandes) {
    commandes = listeCommandes;
  }

  @override
  String toString() {
    return "$titre ($dateDebut -> $dateFin) : $description [$statut]";
  }

  String getStatut() {
    if (statut == StatutEvenement.BROUILLON) return "Brouillon";
    if (statut == StatutEvenement.A_VENIR) return "À venir";
    if (statut == StatutEvenement.EN_COURS) return "En cours";
    if (statut == StatutEvenement.TRAITEMENT) return "En cours de traitement";
    if (statut == StatutEvenement.RETRAIT) return "Retrait des commandes";
    if (statut == StatutEvenement.CLOTURE) return "Clôturé";
    return "Non défini";
  }
}
