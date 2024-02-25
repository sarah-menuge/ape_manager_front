import 'package:ape_manager_front/models/Evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class EvenementsDetailsWidget extends StatelessWidget {
  final Evenement evenement;
  final Widget listeView;
  static double prixTotal = 23.99;

  const EvenementsDetailsWidget(
      {super.key, required this.evenement, required this.listeView});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right:
                  ResponsiveConstraint.getResponsiveValue(context, 20.0, 0.0)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTitreEvenement(context),
                getDescriptionEvenement(context),
                getStatutEvenement(context),
                getBoutonPartagerEvenement(context),
                const Divider(thickness: 0.5),
                listeView,
                getPrixTotal(context),
                getBoutonFinaliserCommande(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitreEvenement(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          evenement.titre,
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_TITRE, POLICE_DESKTOP_TITRE)),
        ),
      ),
    );
  }

  Widget getDescriptionEvenement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text(
        evenement.description,
        textAlign: TextAlign.left,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL, POLICE_DESKTOP_NORMAL),
            fontWeight: FONT_WEIGHT_NORMAL),
      ),
    );
  }

  Widget getStatutEvenement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Statut : ",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL, POLICE_DESKTOP_NORMAL),
                fontWeight: FONT_WEIGHT_NORMAL,
              ),
            ),
            TextSpan(
              text: evenement.statut,
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL, POLICE_DESKTOP_NORMAL),
                color: evenement.statut == "En cours"
                    ? const Color.fromRGBO(0, 86, 27, 100)
                    : GRIS_TRES_FONCE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPrixTotal(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Prix total : ${prixTotal}€",
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL, POLICE_DESKTOP_NORMAL),
          ),
        ),
      ),
    );
  }

  Widget getBoutonPartagerEvenement(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ResponsiveConstraint.getResponsiveValue(context, 0.0, 10.0)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonAppli(
            text: "Partager l'événement",
            background: ROUGE,
            foreground: BLANC,
            routeName: "",
          ),
        ],
      ),
    );
  }

  Widget getBoutonFinaliserCommande(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical:
              ResponsiveConstraint.getResponsiveValue(context, 10.0, 10.0)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonAppli(
            text: "Finaliser la commande",
            background: VERT,
            foreground: BLANC,
            routeName: "",
          ),
        ],
      ),
    );
  }
}
