import 'package:ape_manager_front/export/export_excel.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class DetailEvenementOrganisateur extends StatelessWidget {
  final Evenement evenement;
  final String libelleEvenement;
  final List<Commande> commandes;
  final EvenementProvider evenementProvider;
  final UtilisateurProvider utilisateurProvider;
  final Function? commandeRetraitFonction;
  final Function? commandePayerFonction;
  final Function? evenementCloturerFonction;
  final Function? evenementRetirerFonction;
  final Function? forcerFinPaiement;
  final Map<String, int> listingCommandes;

  const DetailEvenementOrganisateur(
      {super.key,
      required this.commandes,
      required this.libelleEvenement,
      required this.listingCommandes,
      required this.evenement,
      required this.evenementProvider,
      required this.utilisateurProvider,
      this.commandeRetraitFonction,
      this.commandePayerFonction,
      this.evenementCloturerFonction,
      this.evenementRetirerFonction,
      this.forcerFinPaiement});

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
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: commandes.map((commande) {
                return getListeCommandeWidget(context, commande);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: getBoutonActionEvenement(context),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 50),
          ),
          if (estDesktop(context, 600))
            Align(
              alignment: Alignment.center,
              child: BoutonAction(
                  text: "Exporter au format Excel",
                  fonction: () {
                    exporterListingExcel(context);
                  }),
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
              "Commande n° ${commande.getNumeroCommande()} - ${commande.utilisateur.prenom} ${commande.utilisateur.nom}",
              style: FontUtils.getFontApp(
                  fontSize: ResponsiveConstraint.getResponsiveValue(context,
                      POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2)),
            ),
          ),
          Expanded(
            child: estDesktop(context, 710)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getBoutonFonctionStatut(context, commande),
                      BoutonNavigationGoRouter(
                        text: "Plus de détails",
                        routeName: "/commandes/${commande.id}",
                        themeCouleur: ThemeCouleur.bleu,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      getBoutonFonctionStatut(context, commande),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: BoutonNavigationGoRouter(
                          text: "Plus de détails",
                          routeName: "/commandes/${commande.id}",
                          themeCouleur: ThemeCouleur.bleu,
                        ),
                      ),
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
    if (commande.getStatut() == "En attente de paiement") {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: BoutonAction(
          text: "Valider le paiement",
          themeCouleur: ThemeCouleur.vert,
          fonction: () => commandePayerFonction!(commande.id),
        ),
      );
    }
    if (commande.getStatut() == "Payée") {
      return Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Text(
          "Paiement validé",
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
    if (commande.getStatut() == "Annulée") {
      return Padding(
        padding: const EdgeInsets.only(right: 40.0),
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
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: BoutonAction(
          text: "Valider le retrait",
          themeCouleur: ThemeCouleur.vert,
          fonction: () => commandeRetraitFonction!(commande.id),
        ),
      );
    }
    if (commande.getStatut() == "Clôturée") {
      return Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Text(
          "Commande clôturée",
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

  Widget getBoutonActionEvenement(BuildContext context) {
    //  Passage du statut EN COURS DE TRAITEMENT à RETRAIT DES COMMANDES
    if (evenement.getStatut() == "En cours de traitement") {
      if (!evenement.finPaiement) {
        return Align(
          alignment: Alignment.center,
          child: BoutonAction(
            text: "Forcer la fin des paiements",
            fonction: () => forcerFinPaiement!(evenement.id),
            themeCouleur: ThemeCouleur.rouge,
          ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: BoutonAction(
              text: "Passer au retrait",
              fonction: () => evenementRetirerFonction!(evenement.id)),
        );
      }
    }

    // Passage du statut RETRAIT DES COMMANDES à CLOTURER
    if (evenement.getStatut() == "Retrait des commandes") {
      return Align(
        alignment: Alignment.center,
        child: BoutonAction(
          text: "Clôturé l'événement",
          fonction: () => evenementCloturerFonction!(evenement.id),
          themeCouleur: ThemeCouleur.rouge,
        ),
      );
    }
    return Container();
  }

  void exporterListingExcel(BuildContext context) {
    ExportExcel excel = ExportExcel();
    excel.ajouterFeuille("Feuille 1", true);
    excel.ajouterValeurs("Feuille 1",
        ["Nom de l'article", "Quantité total à commander"], listingCommandes);
    excel.enregistrerExcel(context, "Listing_des_commandes_$libelleEvenement");
  }
}
