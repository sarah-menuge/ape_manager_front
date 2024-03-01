enum StatutCommande { VALIDEE, ANNULEE, A_RETIRER, RETIREE, NON_DEFINI }

class Commande {
  late int id;
  late DateTime dateRetrait;
  late String lieuRetrait;
  late StatutCommande statut;

  Commande({
    required this.id,
    required this.dateRetrait,
    required this.lieuRetrait,
    required this.statut,
  });

  Commande.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    dateRetrait = DateTime.parse(json["date_retrait"]);
    lieuRetrait = json["lieu_retrait"];
    try {
      if (json["statut"] == "VALIDEE")
        statut = StatutCommande.VALIDEE;
      else if (json["statut"] == "ANNULEE")
        statut = StatutCommande.ANNULEE;
      else if (json["statut"] == "A_RETIRER")
        statut = StatutCommande.A_RETIRER;
      else if (json["statut"] == "RETIREE")
        statut = StatutCommande.RETIREE;
      else
        statut = StatutCommande.NON_DEFINI;
    } catch (e) {
      statut = StatutCommande.NON_DEFINI;
    }
  }

  String getStatut() {
    if (statut == StatutCommande.VALIDEE) return "Validée";
    if (statut == StatutCommande.ANNULEE) return "Annulée";
    if (statut == StatutCommande.A_RETIRER) return "À retirer";
    if (statut == StatutCommande.RETIREE) return "Retirée";
    if (statut == StatutCommande.NON_DEFINI) return "Non défini";
    return "Non défini";
  }
}
