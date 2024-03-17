class LieuRetrait {
  late int id;
  late String lieu;

  LieuRetrait({required this.id, required this.lieu});

  LieuRetrait.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    lieu = json["place"];
  }

  LieuRetrait.copie(LieuRetrait other) {
    id = other.id;
    lieu = other.lieu;
  }
}
