import 'package:ape_manager_front/models/organisateur.dart';

class ModificationEvenementForm {
  String titreEvenement = "";
  List<Organisateur> organisateursExistants = [];
  List<Organisateur> organisateursSelectionnes = [];

  List<Organisateur> get organisateursSelect => organisateursExistants
      .where((o) => !organisateursSelectionnes.contains(o))
      .toList();

  ModificationEvenementForm.fromJson(Map<String, dynamic> json) {
    ;
  }

  String? estValide() {
    if (titreEvenement == "") return "Le titre de l'événement est obligatoire";
    return null;
  }
}
