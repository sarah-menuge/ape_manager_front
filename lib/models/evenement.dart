import 'organisateur.dart';

class Evenement {
  late int id;
  late String titre;
  late String lieu;
  late DateTime dateDebut;
  late DateTime dateFin;
  late String description;
  late List<Organisateur> organisateurs;

  Evenement({required this.id, required this.titre, required this.lieu, required this.dateDebut, required this.dateFin, required this.description, required this.organisateurs});

  Evenement.fromJson(Map<String, dynamic> json){
    id = json["id"];
    titre = json["titre"];
    lieu = json["lieu"];
    dateDebut = DateTime.parse(json["dateDebut"]);
    dateFin = DateTime.parse(json["dateFin"]);
    description = json["description"];
    organisateurs = (json["organisateurs"] as List<dynamic>)
        .map((e) => Organisateur.fromJson(e))
        .toList();
  }

  @override
  String toString(){
    return "$titre - $lieu [$dateDebut -> $dateFin] : $description";
  }
}