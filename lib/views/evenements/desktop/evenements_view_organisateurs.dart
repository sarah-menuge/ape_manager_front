// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:flutter/material.dart';

enum TypeBouton { Detail, Notification, Modifier }

class OrganisateurDesktopView extends StatelessWidget {
  const OrganisateurDesktopView({super.key});

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
              type_button: TypeBouton.Notification,
            ),
            EvenementWidget(
              periode: "mer. 30 juin. 2024",
              operation: "Opération pique-nique",
              type_button: TypeBouton.Notification,
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

class EvenementWidget extends StatelessWidget {
  final String periode;
  final String operation;
  final String? lieu;
  final TypeBouton type_button;

  const EvenementWidget({
    required this.periode,
    required this.operation,
    required this.type_button,
    this.lieu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 60),
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  operation,
                  style: FontUtils.getFontApp(
                    fontSize: 18,
                  ),
                ),
                Text(
                  periode,
                  style: FontUtils.getFontApp(
                    fontSize: 18,
                  ),
                ),
                if (type_button == TypeBouton.Detail)
                  ButtonAppli(
                      text: "Plus de détail",
                      background: BLEU,
                      foreground: BLANC,
                      routeName: ""),
                if (type_button == TypeBouton.Notification)
                  ButtonAppli(
                      text: "Recevoir une notification",
                      background: ROUGE,
                      foreground: BLANC,
                      routeName: ""),
                if (type_button == TypeBouton.Modifier)
                  ButtonAppli(
                      text: "Modifier l'événement",
                      background: ROUGE,
                      foreground: BLANC,
                      routeName: ""),
              ],
            ),
          ),
          Divider(
            thickness: 0.2,
          ),
        ],
      ),
    );
  }
}
