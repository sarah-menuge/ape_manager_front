import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class DetailEvenementOrganisateur extends StatelessWidget {
  final List<Commande> commandes;

  const DetailEvenementOrganisateur({super.key, required this.commandes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Listing des commandes :",
            style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: commandes.map((commande) {
                return getListeCommandeWidget(context, commande);
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 50),
          ),
        ],
      ),
    );
  }

  Widget getListeCommandeWidget(BuildContext context, Commande commande) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Commande n° ${commande.id} - Nom Prénom de l'utilisateur",
              style: FontUtils.getFontApp(
                  fontSize: ResponsiveConstraint.getResponsiveValue(context,
                      POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2)),
            ),
          ),
          Expanded(
            child: MediaQuery.of(context).size.width > 710
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getBoutonFonctionStatut(context, commande),
                      const BoutonNavigation(
                          text: "Plus de détails",
                          background: BLEU,
                          foreground: BLANC,
                          routeName: ""),
                    ],
                  )
                : Column(
                    children: [
                      getBoutonFonctionStatut(context, commande),
                      const BoutonNavigation(
                          text: "Plus de détails",
                          background: BLEU,
                          foreground: BLANC,
                          routeName: ""),
                    ],
                  ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
        ],
      ),
    );
  }

  Widget getBoutonFonctionStatut(BuildContext context, Commande commande) {
    if (commande.getStatut() == "Validée") {
      return const Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: BoutonNavigation(
            text: "Valider le paiement",
            background: VERT,
            foreground: BLANC,
            routeName: ""),
      );
    }
    if (commande.getStatut() == "Annulée") {
      return Padding(
        padding: EdgeInsets.only(right: 40.0),
        child: Text(
          "Commande annulée",
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
              context,
              POLICE_MOBILE_NORMAL_2,
              POLICE_DESKTOP_NORMAL_2,
            ),
            fontWeight: FONT_WEIGHT_NORMAL,
          ),
        ),
      );
    }
    if (commande.getStatut() == "À retirer") {
      return const Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: BoutonNavigation(
            text: "Valider le retrait",
            background: VERT,
            foreground: BLANC,
            routeName: ""),
      );
    }
    if (commande.getStatut() == "Retirée") {
      return Padding(
        padding: EdgeInsets.only(right: 40.0),
        child: Text(
          "Retrait validé",
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
            fontWeight: FONT_WEIGHT_NORMAL,
          ),
        ),
      );
    }
    return Container();
  }
}
