import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/modification/modifier_evenement_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'notification_popup.dart';

class WidgetEvenement extends StatelessWidget {
  final UtilisateurProvider utilisateurProvider;
  final Evenement evenement;
  final TypeBouton typeBouton;
  final Function? modifierUtilisateurNotifie;

  const WidgetEvenement({
    super.key,
    required this.typeBouton,
    required this.evenement,
    required this.utilisateurProvider,
    this.modifierUtilisateurNotifie,
  });

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    String filtreDate = MediaQuery.of(context).size.width > 600
        ? 'E dd MMM yyyy'
        : 'dd MMM yyyy';
    String formattedDateDebut = evenement.dateDebut != null
        ? DateFormat(filtreDate, 'fr_FR').format(evenement.dateDebut!)
        : "";
    String formattedDateFin = evenement.dateFin != null
        ? DateFormat(filtreDate, 'fr_FR').format(evenement.dateFin!)
        : "";
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
          (estDesktop(context, 600))
              ? getDescriptionDesktop(evenement.description)
              : getDescriptionMobile(context, evenement.description),
          if (typeBouton == TypeBouton.Detail)
            BoutonNavigationGoRouter(
              text: "Plus de détails",
              routeName: DetailEvenementView.routeURL.replaceAll(
                ":idEvent",
                evenement.id.toString(),
              ),
            ),
          if (typeBouton == TypeBouton.Notification)
            if (evenement.dateDebut != null)
              BoutonAction(
                text: "Me notifier",
                fonction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NotificationPopup(
                        idEvenement: evenement.id,
                        titreEvenement: evenement.titre,
                        dateDebut: evenement.dateDebut!,
                        utilisateurNotifie: evenement
                            .emailUtilisateursNotification
                            .contains(utilisateurProvider.utilisateur?.email),
                        modifierUtilisateurNotifie: modifierUtilisateurNotifie,
                      );
                    },
                  );
                },
                themeCouleur: ThemeCouleur.rouge,
              ),
          getBoutonModifierSiProprietaire(context),
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
                  child: const Text("OK"),
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
    );
  }

  Widget getBoutonModifierSiProprietaire(BuildContext context) {
    if (typeBouton == TypeBouton.Modifier) {
      if (utilisateurProvider.utilisateur!.email ==
              evenement.proprietaire.email ||
          utilisateurProvider.estAdmin) {
        return BoutonNavigationGoRouter(
          text: "Modifier",
          routeName: "/modifier-evenement/${evenement.id}",
          themeCouleur: ThemeCouleur.rouge,
        );
      }

      for (Organisateur organisateur in evenement.organisateurs) {
        if (utilisateurProvider.utilisateur!.email == organisateur.email) {
          return BoutonNavigationGoRouter(
            text: "Plus de détails",
            routeName: "/modifier-evenement/${evenement.id}",
            themeCouleur: ThemeCouleur.bleu,
          );
        }
      }

      return const BoutonNavigationGoRouter(
        text: "Non accessible",
        routeName: "",
        themeCouleur: ThemeCouleur.gris,
      );
    }
    return Container();
  }
}
