// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/views/evenements/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:flutter/material.dart';

class EvenementsViewOrganisateur extends StatelessWidget {
  const EvenementsViewOrganisateur({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: ButtonAppli(
            text: "Créer un événement",
            background: VERT,
            foreground: NOIR,
            routeName: "",
          ),
        ),
        ExpansionTileAppli(
          titre: "Événements brouillons",
          listeWidget: [
            EvenementWidget(
              periode: "lun. 20 févr. 2024",
              operation: "Opération fleurs",
              type_button: TypeBouton.Modifier,
            ),
            EvenementWidget(
              periode: "ven. 24 févr. 2024",
              operation: "Opération chocolat",
              type_button: TypeBouton.Modifier,
            )
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements à venir",
          listeWidget: [
            EvenementWidget(
              periode: "jeu. 1 avri. 2024",
              operation: "Opération serviettes",
              type_button: TypeBouton.Modifier,
            ),
            EvenementWidget(
              periode: "mer. 30 juin. 2024",
              operation: "Opération pique-nique",
              type_button: TypeBouton.Modifier,
            ),
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements en cours",
          listeWidget: [
            EvenementWidget(
              periode: "lun. 20 févr. 2024",
              operation: "Opération fleurs",
              type_button: TypeBouton.Detail,
            ),
            EvenementWidget(
              periode: "ven. 24 févr. 2024",
              operation: "Opération chocolat",
              type_button: TypeBouton.Detail,
            )
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements clôturés",
          expanded: false,
          listeWidget: [
            EvenementWidget(
              periode: "lun. 20 févr. 2024",
              operation: "Opération fleurs",
              type_button: TypeBouton.Detail,
            ),
            EvenementWidget(
              periode: "ven. 24 févr. 2024",
              operation: "Opération chocolat",
              type_button: TypeBouton.Detail,
            )
          ],
        ),
      ],
    );
  }
}
