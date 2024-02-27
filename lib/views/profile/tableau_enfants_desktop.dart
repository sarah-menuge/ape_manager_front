import 'package:ape_manager_front/utils/utilitaire_texte.dart';
import 'package:flutter/material.dart';

import '../../models/enfant.dart';
import '../../proprietes/couleurs.dart';

class TableauEnfantsDesktop extends StatefulWidget {
  Function modifierEnfant;
  Function supprimerEnfant;
  late List<Enfant> enfants;

  TableauEnfantsDesktop({
    required this.modifierEnfant,
    required this.supprimerEnfant,
    required this.enfants,
  });

  @override
  _TableauEnfantsDesktopState createState() => _TableauEnfantsDesktopState(
        modifierEnfant: modifierEnfant,
        supprimerEnfant: supprimerEnfant,
        enfants: enfants,
      );
}

class _TableauEnfantsDesktopState extends State<TableauEnfantsDesktop> {
  Function modifierEnfant;
  Function supprimerEnfant;
  List<Enfant> enfants;

  _TableauEnfantsDesktopState({
    required this.modifierEnfant,
    required this.supprimerEnfant,
    required this.enfants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(BEIGE_FONCE),
          columns: const [
            DataColumn(
                label:
                    Text('Nom', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Prénom',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Classe',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: enfants
              .map(
                (enfant) => DataRow(
                  cells: [
                    DataCell(Text(tronquerTexte(enfant.nom, 20))),
                    DataCell(Text(tronquerTexte(enfant.prenom, 20))),
                    DataCell(Text(enfant.classe)),
                    DataCell(
                      const Icon(Icons.edit),
                      onTap: () => modifierEnfant(enfant),
                    ),
                    DataCell(
                      const Icon(Icons.delete),
                      onTap: () => supprimerEnfant(enfant),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
