// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
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
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
          ),
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
              shortDescription: "Vente de fleurs",
              type_button: TypeBouton.Modifier,
            ),
            EvenementWidget(
              periode: "ven. 24 févr. 2024",
              operation: "Opération chocolat",
              shortDescription: "Vente de chocolat",
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
              shortDescription: "Vente de serviettes personnalisées",
              type_button: TypeBouton.Modifier,
            ),
            EvenementWidget(
              periode: "mer. 30 juin. 2024",
              operation: "Opération pique-nique",
              shortDescription:
                  "Vente de pique-nique pour la sortie dans la forêt",
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
              shortDescription: "Vente de fleurs",
              type_button: TypeBouton.Detail,
            ),
            EvenementWidget(
              periode: "ven. 24 févr. 2024",
              operation: "Opération chocolat",
              shortDescription: "Vente de chocolat",
              type_button: TypeBouton.Detail,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: ResponsiveConstraint.getResponsiveValue(context, 20.0, 0.0),
          ),
          child: ExpansionTileAppli(
            titre: "Événements clôturés",
            expanded: false,
            listeWidget: [
              EvenementWidget(
                periode: "lun. 20 févr. 2024",
                operation: "Opération fleurs",
                shortDescription: "Vente de fleurs",
                type_button: TypeBouton.Detail,
              ),
              EvenementWidget(
                periode: "ven. 24 févr. 2024",
                operation: "Opération chocolat",
                shortDescription: "Vente de chocolat",
                type_button: TypeBouton.Detail,
              )
            ],
          ),
        ),
      ],
    );
  }
}
