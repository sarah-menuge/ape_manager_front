import 'package:ape_manager_front/models/donnee_tableau.dart';

class LieuRetrait extends DonneeTableau {
  late int id;
  late String lieu;

  LieuRetrait() {
    id = -1;
    lieu = "";
  }

  LieuRetrait.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    lieu = json["place"];
  }

  LieuRetrait.copie(LieuRetrait other) {
    try {
      id = other.id;
    } catch (e) {
      id = -1;
    }
    lieu = other.lieu;
  }

  @override
  String toString() {
    return lieu;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != LieuRetrait) return false;
    LieuRetrait l = other as LieuRetrait;
    return lieu == l.lieu;
  }

  /// Méthodes à implémenter pour afficher l'objet sous forme de tableau

  @override
  getValeur(String nom_colonne) {
    if (nom_colonne == "Lieu de retrait") return lieu;
  }

  @override
  List<String> intitulesHeader() {
    return ["Lieu de retrait"];
  }

  @override
  Map<String, dynamic> pourTableau() {
    return {
      "Lieu de retrait": lieu,
    };
  }
}
