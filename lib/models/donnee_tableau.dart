abstract class DonneeTableau {
  Map<String, dynamic> pourTableau();

  List<String> intitulesHeader();

  dynamic getValeur(String nom_colonne);
}
