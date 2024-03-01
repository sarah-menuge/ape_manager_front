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

  Evenement(
      {required this.id,
      required this.titre,
      required this.lieu,
      required this.dateDebut,
      required this.dateFin,
      required this.dateFinPaiement,
      required this.statut,
      required this.description,
      required this.organisateurs});

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

  @override
  String toString() {
    return "$titre - $lieu ($dateDebut -> $dateFin -> $dateFinPaiement) : $description [$statut]";
  }

  String getStatut() {
    if (statut == StatutEvenement.BROUILLON) return "Brouillon";
    if (statut == StatutEvenement.A_VENIR) return "A venir";
    if (statut == StatutEvenement.EN_COURS) return "En cours";
    if (statut == StatutEvenement.CLOTURE)
      return "Clôturé";
    else
      return "Non défini";
  }
}