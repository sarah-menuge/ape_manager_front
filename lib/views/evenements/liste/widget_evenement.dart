import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class WidgetEvenement extends StatelessWidget {
  final String titreEvenement;
  final String dateDebut;
  final String dateFin;
  final String description;
  final TypeBouton typeBouton;

  const WidgetEvenement(
      {super.key,
      required this.titreEvenement,
      required this.dateDebut,
      required this.dateFin,
      required this.description,
      required this.typeBouton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              ResponsiveConstraint.getResponsiveValue(context, 0.0, 20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    titreEvenement,
                    textAlign: TextAlign.left,
                    style: FontUtils.getFontApp(
                      fontSize: ResponsiveConstraint.getResponsiveValue(context,
                          POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "$dateDebut - $dateFin",
                    textAlign: TextAlign.left,
                    style: FontUtils.getFontApp(
                      fontWeight: FONT_WEIGHT_NORMAL,
                      fontSize: ResponsiveConstraint.getResponsiveValue(context,
                          POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          (MediaQuery.of(context).size.width > 600)
              ? getDescriptionDesktop(description)
              : getDescriptionMobile(context, description),
          if (typeBouton == TypeBouton.Detail)
            ButtonAppli(
                text: "Plus de détail",
                background: BLEU_CLAIR,
                foreground: BLANC,
                routeName: EvenementsDetailsView.routeName),
          if (typeBouton == TypeBouton.Notification)
            const ButtonAppli(
                text: "Me notifier",
                background: ROUGE,
                foreground: BLANC,
                routeName: ""),
          if (typeBouton == TypeBouton.Modifier)
            const ButtonAppli(
                text: "Modifier",
                background: ROUGE,
                foreground: BLANC,
                routeName: ""),
        ],
      ),
    );
  }

  Widget getDescriptionMobile(BuildContext context, String description) {
    return Tooltip(
      message: 'Informations',
      child: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Description de l'événement",
                style: FontUtils.getFontApp(
                  fontSize: 18,
                ),
              ),
              content: Text(description),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getDescriptionDesktop(String description) {
    return Expanded(
      flex: 2,
      child: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: FontUtils.getFontApp(
              fontSize: POLICE_DESKTOP_NORMAL_2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
