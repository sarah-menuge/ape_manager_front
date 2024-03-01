import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/commande.dart';

import 'organisateur.dart';

enum StatutEvenement { BROUILLON, A_VENIR, EN_COURS, CLOTURE, NON_DEFINI }

class Evenement {
  late int id;
  late String titre;
  late String lieu;
  late DateTime dateDebut;
  late DateTime dateFin;
  late DateTime dateFinPaiement;
  late String description;
  late StatutEvenement statut;
  late List<Organisateur> organisateurs;
  List<Article> articles = [];
  List<Commande> commandes = [];

  Evenement({
    required this.id,
    required this.titre,
    required this.lieu,
    required this.dateDebut,
    required this.dateFin,
    required this.dateFinPaiement,
    required this.description,
    required this.organisateurs,
    required this.articles,
    required this.commandes,
  });

  Evenement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    titre = json["titre"];
    lieu = json["lieu"];
    dateDebut = DateTime.parse(json["dateDebut"]);
    dateFin = DateTime.parse(json["dateFin"]);
    try {
      dateFinPaiement = DateTime.parse(json["dateFinPaiement"]);
    } catch (e) {
      dateFinPaiement = dateFin;
    }
    description = json["description"];
    try {
      if (json["statut"] == "BROUILLON")
        statut = StatutEvenement.BROUILLON;
      else if (json["statut"] == "A_VENIR")
        statut = StatutEvenement.A_VENIR;
      else if (json["statut"] == "EN_COURS")
        statut = StatutEvenement.EN_COURS;
      else if (json["statut"] == "CLOTURE")
        statut = StatutEvenement.CLOTURE;
      else
        statut = StatutEvenement.NON_DEFINI;
    } catch (e) {
      statut = StatutEvenement.NON_DEFINI;
    }
    organisateurs = (json["organisateurs"] as List<dynamic>)
        .map((e) => Organisateur.fromJson(e))
        .toList();
  }

  void setArticles(listeArticles) {
    articles = listeArticles;
  }

  void setCommandes(listeCommandes) {
    commandes = listeCommandes;
  }

  @override
  String toString() {
    return "$titre - $lieu ($dateDebut -> $dateFin -> $dateFinPaiement) : $description [$statut]";
  }

  String getStatut() {
    if (statut == StatutEvenement.BROUILLON) return "Brouillon";
    if (statut == StatutEvenement.A_VENIR) return "À venir";
    if (statut == StatutEvenement.EN_COURS) return "En cours";
    if (statut == StatutEvenement.CLOTURE) return "Clôturé";
    return "Non défini";
  }
}
