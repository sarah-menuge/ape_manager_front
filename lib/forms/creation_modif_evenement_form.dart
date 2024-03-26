import 'package:ape_manager_front/models/organisateur.dart';
import 'package:intl/intl.dart';

class CreationModifEvenementForm {
  String titreEvenement = "";
  List<Organisateur> organisateursExistants = [];
  List<Organisateur> organisateursSelectionnes = [];

  List<Organisateur> get organisateursSelect => organisateursExistants
      .where((o) => !organisateursSelectionnes.contains(o))
      .toList();

  List<Organisateur> get organisateursSelected => organisateursSelectionnes;

  String? estValide() {
    if (titreEvenement == "") return "Le titre de l'événement est obligatoire";
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": titreEvenement,
      "organizers": [
        for (Organisateur o in organisateursSelectionnes) o.id,
      ],
      "places": [],
      "startDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "endDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };
  }
}
