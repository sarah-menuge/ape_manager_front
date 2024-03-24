import 'package:ape_manager_front/models/bouton_radio.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_organisateur.dart';
import 'package:ape_manager_front/views/evenements/details/popup_finaliser_commande.dart';
import 'package:ape_manager_front/views/evenements/details/popup_partage.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/groupe_boutons_radio.dart';
import 'package:ape_manager_front/widgets/texte/texte_flexible.dart';
import 'package:flutter/material.dart';

class DetailEvenementWidget extends StatelessWidget {
  final UtilisateurProvider utilisateurProvider;
  final EvenementProvider evenementProvider;
  final CommandeProvider commandeProvider;

  final Evenement evenement;
  final Widget listeView;
  final Panier panier;
  final Map<String, int> listingCommande;

  final Function? validerPaiementFonction;
  final Function? validerRetraitFonction;
  final Function? evenementCloturerFonction;
  final Function? evenementRetirerFonction;
  final Function? forcerFinPaiement;

  const DetailEvenementWidget({
    super.key,
    required this.evenementProvider,
    required this.commandeProvider,
    required this.utilisateurProvider,
    required this.evenement,
    required this.listeView,
    required this.panier,
    required this.listingCommande,
    this.evenementCloturerFonction,
    this.evenementRetirerFonction,
    this.forcerFinPaiement,
    this.validerPaiementFonction,
    this.validerRetraitFonction,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                  if (utilisateurProvider.perspective == Perspective.PARENT &&
                      evenement.lieux.isNotEmpty) ...[
                    getLieuxRetrait(),
                    const Divider(thickness: 0.5),
                  ],
                  listeView,
                  if (utilisateurProvider.perspective == Perspective.PARENT &&
                      evenement.articles.isNotEmpty) ...[
                    getPrixTotal(context),
                    getBoutonFinaliserCommande(context),
                  ],
                  if (utilisateurProvider.perspective == Perspective.ORGANIZER)
                    DetailEvenementOrganisateur(
                      listingCommandes: listingCommande,
                      commandes: evenement.commandes,
                      libelleEvenement: evenement.titre,
                      validerPaiementFonction: validerPaiementFonction,
                      validerRetraitFonction: validerRetraitFonction,
                      evenementCloturerFonction: evenementCloturerFonction,
                      evenementRetirerFonction: evenementRetirerFonction,
                      forcerFinPaiement: forcerFinPaiement,
                      utilisateurProvider: utilisateurProvider,
                      evenementProvider: evenementProvider,
                      commandeProvider: commandeProvider,
                      evenement: evenement,
                    ),
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
    bool enCours = false;
    if (evenement.getStatut() == "En cours" ||
        evenement.getStatut() == "En cours de traitement" ||
        evenement.getStatut() == "Retrait des commandes") enCours = true;
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
                color:
                    enCours ? const Color.fromRGBO(0, 86, 27, 100) : GRIS_CLAIR,
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
          "Prix total : ${panier.prixTotal.toStringAsFixed(2)} €",
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
          BoutonAction(
            text: "Partager l'événement",
            themeCouleur: ThemeCouleur.rouge,
            fonction: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopupPartage(
                    titreEvenement: evenement.titre,
                    dateDebut: evenement.dateDebut,
                    dateFin: evenement.dateFin,
                    lien: URL_API + "#/evenements/${evenement.id}",
                  );
                },
              );
            },
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
                    if (panier.idLieuRetrait == -1 &&
                        evenement.lieux.isNotEmpty) {
                      afficherMessageInfo(
                        context: context,
                        message:
                            "Veuillez choisir un lieu de retrait avant de finaliser la commande.",
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupFinaliserCommande(
                          commandeProvider: commandeProvider,
                          panier: panier,
                        );
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget getLieuxRetrait() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Choisissez un lieu de retrait :",
              style: FontUtils.getFontApp(fontSize: 20)),
          GroupeBoutonsRadio(
            boutonsRadio: [
              for (LieuRetrait lieuRetrait in evenement.lieux)
                BoutonRadio(id: lieuRetrait.id, libelle: lieuRetrait.lieu),
            ],
            idBoutonRadioSelectionne:
                panier.idLieuRetrait != -1 ? panier.idLieuRetrait : null,
            onChangedMethod: (value) => panier.idLieuRetrait = value!,
          ),
        ],
      ),
    );
  }
}
