import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_organisateur.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class DetailEvenementWidget extends StatelessWidget {
  final Evenement evenement;
  final Widget listeView;
  final Panier panier;
  final UtilisateurProvider utilisateurProvider;

  const DetailEvenementWidget(
      {super.key,
      required this.evenement,
      required this.listeView,
      required this.panier,
      required this.utilisateurProvider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BoutonRetour(nomUrlRetour: EvenementsView.routeURL),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: ResponsiveConstraint.getResponsiveValue(
                  context,
                  20.0,
                  0.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitreEvenement(context),
                  getDescriptionEvenement(context),
                  getStatutEvenement(context),
                  getBoutonPartagerEvenement(context),
                  const Divider(thickness: 0.5),
                  listeView,
                  if (utilisateurProvider.perspective == Perspective.PARENT)
                    getPrixTotal(context),
                  if (utilisateurProvider.perspective == Perspective.PARENT)
                    getBoutonFinaliserCommande(context),
                  if (utilisateurProvider.perspective ==
                      Perspective.ORGANISATEUR)
                    DetailEvenementOrganisateur(commandes: evenement.commandes),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitreEvenement(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        evenement.titre,
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
      ),
    );
  }

  Widget getDescriptionEvenement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        evenement.description,
        textAlign: TextAlign.left,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
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
                    context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                fontWeight: FONT_WEIGHT_NORMAL,
              ),
            ),
            TextSpan(
              text: evenement.getStatut(),
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                color: evenement.getStatut() == "En cours"
                    ? const Color.fromRGBO(0, 86, 27, 100)
                    : GRIS_CLAIR,
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Prix total : ${panier.getPrixTotal().toStringAsFixed(2)} €",
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
          ),
        ),
      ),
    );
  }

  Widget getBoutonPartagerEvenement(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ResponsiveConstraint.getResponsiveValue(context, 0.0, 10.0),
          right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BoutonNavigationGoRouter(
            text: "Partager l'événement",
            routeName: "/evenements/${evenement.id}/partager",
            themeCouleur: ThemeCouleur.rouge,
          ),
        ],
      ),
    );
  }

  Widget getBoutonFinaliserCommande(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 10,
          bottom: ResponsiveConstraint.getResponsiveValue(context, 40.0, 10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          panier.articles.isEmpty
              ? const BoutonAction(
                  text: "Finaliser la commande",
                  disable: true,
                  fonction: null,
                  themeCouleur: ThemeCouleur.gris,
                )
              : BoutonAction(
                  text: "Finaliser la commande",
                  themeCouleur: ThemeCouleur.vert,
                  fonction: () {
                    afficherLogCritical(
                        "Finaliser la commande : non pris en charge");
                  },
                ),
        ],
      ),
    );
  }
}
