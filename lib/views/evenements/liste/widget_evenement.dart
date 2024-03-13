import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class WidgetEvenement extends StatelessWidget {
  final Evenement evenement;
  final TypeBouton typeBouton;

  const WidgetEvenement(
      {super.key, required this.typeBouton, required this.evenement});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    String filtreDate = MediaQuery.of(context).size.width > 600
        ? 'E dd MMM yyyy'
        : 'dd MMM yyyy';
    String formattedDateDebut =
        DateFormat(filtreDate, 'fr_FR').format(evenement.dateDebut);
    String formattedDateFin =
        DateFormat(filtreDate, 'fr_FR').format(evenement.dateFin);
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
                    evenement.titre,
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
                    ResponsiveConstraint.getResponsiveValue(
                        context,
                        "Du $formattedDateDebut \nAu $formattedDateFin",
                        "$formattedDateDebut - $formattedDateFin"),
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
              ? getDescriptionDesktop(evenement.description)
              : getDescriptionMobile(context, evenement.description),
          if (typeBouton == TypeBouton.Detail)
            BoutonNavigationGoRouter(
              text: "Plus de détails",
              routeName: DetailEvenementView.routeURL.replaceAll(
                ":idEvent",
                evenement.id.toString(),
              ),
              themeCouleur: ThemeCouleur.bleu_clair,
            ),
          if (typeBouton == TypeBouton.Notification)
            const BoutonNavigationGoRouter(
              text: "Me notifier",
              routeName: "/me-notifier-evenement",
              themeCouleur: ThemeCouleur.rouge,
            ),
          if (typeBouton == TypeBouton.Modifier)
            const BoutonNavigationGoRouter(
              text: "Modifier",
              routeName: "/modifier-evenement/0",
              themeCouleur: ThemeCouleur.rouge,
            ),
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
