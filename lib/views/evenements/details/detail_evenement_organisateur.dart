import 'package:ape_manager_front/export/export_excel.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/popup_gestion_commande.dart';
import 'package:ape_manager_front/views/evenements/details/popup_gestion_evenement.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class DetailEvenementOrganisateur extends StatelessWidget {
  final EvenementProvider evenementProvider;
  final CommandeProvider commandeProvider;
  final UtilisateurProvider utilisateurProvider;

  final Evenement evenement;
  final String libelleEvenement;
  final List<Commande> commandes;
  final Map<String, int> listingCommandes;

  final Function? evenementCloturerFonction;
  final Function? evenementRetirerFonction;
  final Function? forcerFinPaiement;
  final Function? validerPaiementFonction;
  final Function? validerRetraitFonction;

  const DetailEvenementOrganisateur({
    super.key,
    required this.evenementProvider,
    required this.utilisateurProvider,
    required this.commandeProvider,
    required this.commandes,
    required this.libelleEvenement,
    required this.listingCommandes,
    required this.evenement,
    this.evenementCloturerFonction,
    this.evenementRetirerFonction,
    this.forcerFinPaiement,
    this.validerPaiementFonction,
    this.validerRetraitFonction,
  });

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
          Column(
            children: commandes.map((commande) {
              return getListeCommandeWidget(context, commande);
            }).toList(),
          ),
          getBoutonActionEvenement(context),
          if (estDesktop(context, 600))
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.center,
                child: BoutonAction(
                    text: "Exporter au format Excel",
                    fonction: () {
                      exporterListingExcel(context);
                    }),
              ),
            ),
        ],
      ),
    );
  }

  Widget getListeCommandeWidget(BuildContext context, Commande commande) {
    return ListTile(
      title: Column(
        children: [
          Row(
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
          const Divider(thickness: 0.5),
        ],
      ),
    );
  }

  Widget getBoutonFonctionStatut(BuildContext context, Commande commande) {
    if (commande.getStatut() == "En attente de paiement") {
      return Padding(
        padding: EdgeInsets.only(right: estDesktop(context, 600) ? 10.0 : 0.0),
        child: BoutonAction(
          text: "Valider le paiement",
          themeCouleur: ThemeCouleur.vert,
          fonction: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PopupGestionCommande(
                  commande: commande,
                  fonctionAEffectuer: validerPaiementFonction,
                  texteBouton: "Valider le paiement",
                  titrePopup: "Confirmer le paiement d'une commande",
                  sousTitrePopup:
                      "Vous vous apprêtez à valider le paiement de la commande n°${commande.getNumeroCommande()}.",
                );
              },
            );
          },
        ),
      );
    }
    if (commande.getStatut() == "Payée") {
      return Padding(
        padding: EdgeInsets.only(right: estDesktop(context, 600) ? 40.0 : 0.0),
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
            color: VERT_1,
          ),
        ),
      );
    }
    if (commande.getStatut() == "Annulée") {
      return Padding(
        padding: EdgeInsets.only(right: estDesktop(context, 600) ? 40.0 : 0.0),
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
            color: ROUGE_1,
          ),
        ),
      );
    }
    if (commande.getStatut() == "À retirer") {
      return Padding(
        padding: EdgeInsets.only(right: estDesktop(context, 600) ? 10.0 : 0.0),
        child: BoutonAction(
          text: "Valider le retrait",
          themeCouleur: ThemeCouleur.vert,
          fonction: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PopupGestionCommande(
                  commande: commande,
                  fonctionAEffectuer: validerRetraitFonction,
                  titrePopup: "Confirmer le retrait d'une commande",
                  sousTitrePopup:
                      "Vous vous apprêtez à valider le retrait de la commande n°${commande.getNumeroCommande()}.",
                  texteBouton: "Valider le retrait",
                );
              },
            );
          },
        ),
      );
    }
    if (commande.getStatut() == "Clôturée") {
      return Padding(
        padding: EdgeInsets.only(right: estDesktop(context, 600) ? 40.0 : 0.0),
        child: Text(
          "Commande clôturée",
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
            fontWeight: FONT_WEIGHT_NORMAL,
            color: GRIS_FONCE,
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
            fonction: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopupGestionEvenement(
                    idEvenement: evenement.id,
                    fonctionAEffectuer: forcerFinPaiement,
                    titrePopup: "Confirmer la fin des paiements",
                    sousTitrePopup:
                        "Vous vous apprêtez à valider la fin des paiements.\nLes commandes non payées vont être annulées.",
                    texteBouton: "Forcer la fin des paiements",
                  );
                },
              );
            },
            themeCouleur: ThemeCouleur.rouge,
          ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: BoutonAction(
            text: "Passer au retrait",
            fonction: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopupGestionEvenement(
                    idEvenement: evenement.id,
                    fonctionAEffectuer: evenementRetirerFonction,
                    titrePopup:
                        "Confirmer le traitement des commandes en attente de retrait",
                    sousTitrePopup:
                        "Vous vous apprêtez à passer les commandes au statut en attente de retrait.",
                    texteBouton: "Passer au retrait",
                  );
                },
              );
            },
          ),
        );
      }
    }

    // Passage du statut RETRAIT DES COMMANDES à CLOTURER
    if (evenement.getStatut() == "Retrait des commandes") {
      return Align(
        alignment: Alignment.center,
        child: BoutonAction(
          text: "Clôturé l'événement",
          fonction: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PopupGestionEvenement(
                  idEvenement: evenement.id,
                  fonctionAEffectuer: evenementCloturerFonction,
                  titrePopup: "Confirmer le clôture de l'événement",
                  sousTitrePopup:
                      "Vous vous apprêtez à clôturer l'événement ${evenement.titre}.",
                  texteBouton: "Clôturer l'événement",
                );
              },
            );
          },
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
