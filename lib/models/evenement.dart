import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late List<LieuRetrait> lieux = [];
  late DateTime? dateDebut;
  late DateTime? dateFin;
  late DateTime? dateFinPaiement;
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
    required this.lieux,
    required this.dateDebut,
    required this.dateFin,
    required this.dateFinPaiement,
    required this.finPaiement,
    required this.statut,
    required this.description,
    required this.proprietaire,
    required this.organisateurs,
    required this.articles,
    required this.commandes,
  });

  Evenement.copie(Evenement other) {
    id = other.id;
    titre = other.titre;
    lieux = other.lieux.map((l) => LieuRetrait.copie(l)).toList();
    dateDebut = other.dateDebut;
    dateFin = other.dateFin;
    dateFinPaiement = other.dateFinPaiement;
    statut = other.statut;
    description = other.description;
    proprietaire = Organisateur.copie(other.proprietaire);
    organisateurs =
        other.organisateurs.map((o) => Organisateur.copie(o)).toList();
    articles = other.articles.map((a) => Article.copie(a)).toList();
    commandes = other.commandes.map((c) => Commande.copie(c)).toList();
  }

  Evenement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    titre = json["title"];
    lieux = (json["places"] as List<dynamic>)
        .map((l) => LieuRetrait.fromJson(l))
        .toList();

    try {
      dateDebut = DateTime.parse(json["startDate"]);
    } catch (e) {
      dateDebut = null;
    }
    try {
      dateFin = DateTime.parse(json["endDate"]);
    } catch (e) {
      dateFin = null;
    }
    try {
      dateFinPaiement = DateTime.parse(json["endOfPaymentDate"]);
    } catch (e) {
      dateFinPaiement = null;
    }

    finPaiement = json["endOfPayment"] == "true" ? true : false;
    description = json["description"] ?? "";

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

  Map<String, dynamic> toJsonInfosGenerales() {
    return {
      "title": titre,
      "startDate":
          dateDebut != null ? DateFormat('yyyy-MM-dd').format(dateDebut!) : "",
      "endDate":
          dateFin != null ? DateFormat('yyyy-MM-dd').format(dateFin!) : "",
      "endOfPaymentDate": dateFinPaiement != null
          ? DateFormat('yyyy-MM-dd').format(dateFinPaiement!)
          : "",
      "description": description,
      "places": lieux.map((e) => e.lieu).toList(),
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

  String getDateDebutString() {
    try {
      return DateFormat('dd-MM-yyyy').format(dateDebut!);
    } catch (e) {
      return "";
    }
  }

  String getDateFinString() {
    try {
      return DateFormat('dd-MM-yyyy').format(dateFin!);
    } catch (e) {
      return "";
    }
  }

  String getDateFinPaiementString() {
    try {
      return DateFormat('dd-MM-yyyy').format(dateFinPaiement!);
    } catch (e) {
      return "";
    }
  }

  TextEditingController get dateDebutTEC =>
      TextEditingController(text: getDateDebutString());

  TextEditingController get dateFinTEC =>
      TextEditingController(text: getDateFinString());

  TextEditingController get dateFinPaiementTEC =>
      TextEditingController(text: getDateFinPaiementString());

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Evenement) return false;
    Evenement e = other as Evenement;
    return e.titre == other.titre &&
        e.description == other.description &&
        e.dateDebut == other.dateDebut &&
        e.dateFin == other.dateFin &&
        e.dateFinPaiement == other.dateFinPaiement;
  }
}
