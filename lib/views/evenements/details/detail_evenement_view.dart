import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/evenements/details/bouton_quantite.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailEvenementView extends StatefulWidget {
  static String routeURL = '/evenements/:idEvent';
  final int eventId;

  const DetailEvenementView({super.key, required this.eventId});

  @override
  State<DetailEvenementView> createState() => _DetailEvenementViewState();
}

class _DetailEvenementViewState extends State<DetailEvenementView> {
  final EvenementProvider evenementProvider = EvenementProvider();
  final CommandeProvider commandeProvider = CommandeProvider();
  late UtilisateurProvider utilisateurProvider;

  Panier panier = Panier();
  Evenement? evenement;

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    fetchEvenement();
  }

  /// Récupération de l'événement demandé
  Future<void> fetchEvenement() async {
    await evenementProvider.fetchEvenement(
      utilisateurProvider.token!,
      widget.eventId,
    );
    evenement = evenementProvider.evenement!;
    await fetchListeArticles();
    await fetchListeCommandes();
    setState(() {
      evenement;
      panier = Panier(
          idEvenement: evenement!.id,
          idLieuRetrait: evenement!.lieux.isEmpty ? 0 : evenement!.lieux[0].id);
    });
  }

  /// Récupération de la liste des articles de l'événement demandé
  Future<void> fetchListeArticles() async {
    await evenementProvider.fetchListeArticles(
      utilisateurProvider.token!,
      evenement!,
    );
  }

  /// Récupération de la liste des commandes de l'événement demandé
  Future<void> fetchListeCommandes() async {
    await evenementProvider.fetchListeCommandes(
      utilisateurProvider.token!,
      evenement!,
    );
  }

  /// Valider le paiement d'une commande
  Future<void> validerPaiement(int idCommande) async {
    final response = await commandeProvider.passerCommandePayee(
        utilisateurProvider.token!, idCommande);
    if (response["statusCode"] != 204 && mounted) {
      // Affiche qu'il y a eut une erreur
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      for (Commande commande in evenement!.commandes) {
        if (commande.id == idCommande) {
          // Ferme la popup
          revenirEnArriere(context);

          // Change le statut d'une commande
          setState(() {
            commande.statut = StatutCommande.VALIDEE;
            commande.estPaye = true;
          });

          // Affiche le message de succès
          afficherMessageSucces(
              context: context,
              message:
                  "La commande n°${commande.getNumeroCommande()} a été payée.",
              duree: 5);
        }
      }
    }
  }

  /// Valider le retrait d'une commande
  Future<void> validerRetrait(int idCommande) async {
    final response = await commandeProvider.passerCommandeRetiree(
        utilisateurProvider.token!, idCommande);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      // Ferme la popup
      revenirEnArriere(context);

      // Change le statut de la commande
      for (Commande commande in evenement!.commandes) {
        if (commande.id == idCommande) {
          setState(() {
            commande.statut = StatutCommande.CLOTUREE;
          });
          // Affiche le message de succès
          afficherMessageSucces(
              context: context,
              message:
                  "La commande n°${commande.getNumeroCommande()} a été retirée.",
              duree: 5);
        }
      }
    }
  }

  /// Forcer la fin de paiement d'un événement
  Future<void> forcerFinPaiement(int idEvenement) async {
    final response = await evenementProvider.annulerCommandeNonPayees(
        utilisateurProvider.token!, idEvenement);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      // Ferme la popup
      revenirEnArriere(context);

      for (Commande commande in evenement!.commandes) {
        if (!commande.estPaye) {
          setState(() {
            commande.statut = StatutCommande.ANNULEE;
          });
          // Affiche le message de succès
          afficherMessageSucces(
              context: context,
              message: "Les commandes non payées ont été annulées.");
        }
      }
    }

    final response_2 = await evenementProvider.forcerFinPaiement(
        utilisateurProvider.token!, idEvenement);
    if (response_2["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      setState(() {
        evenement!.finPaiement = true;
      });
    }
  }

  /// Passer un événement au statut À RETIRER
  Future<void> passerEvenementARetirer(int idEvenement) async {
    final response = await evenementProvider.passerEvenementEnRetrait(
        utilisateurProvider.token!, idEvenement);
    final response_commande = await commandeProvider.passerCommandeEnRetrait(
        utilisateurProvider.token!, idEvenement);
    if (response["statusCode"] != 204 && mounted) {
      if (response_commande["statusCode"] != 204 && mounted) {
        // Affiche un message d'erreur si la commande n'est pas passer en à retirer
        afficherMessageErreur(
            context: context, message: response_commande["message"]);
      }
      // Affiche un message d'erreur si l'événement n'est pas passer en à retirer
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      revenirEnArriere(context);

      setState(() {
        evenement!.statut = StatutEvenement.RETRAIT;
        for (Commande commande in evenement!.commandes) {
          if (commande.statut != StatutCommande.ANNULEE) {
            commande.statut = StatutCommande.A_RETIRER;
          }
        }
      });
      // Affiche le message de succès
      afficherMessageSucces(
          context: context,
          message:
              "L'événement et les commandes sont passés au statut en attente de retrait",
          duree: 5);
    }
  }

  /// Passage d'un événement à l'état clôturé
  Future<void> passerEvenementACloturer(int idEvenement) async {
    final response = await evenementProvider.passerEvenementEnCloture(
        utilisateurProvider.token!, idEvenement);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      revenirEnArriere(context);

      setState(() {
        evenement!.statut = StatutEvenement.CLOTURE;
      });

      // Affiche le message de succès
      afficherMessageSucces(
          context: context, message: "L'événement a été clôturé", duree: 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      nomUrlRetour: EvenementsView.routeURL,
      body: evenement == null
          ? const SizedBox()
          : DetailEvenementWidget(
              commandeProvider: commandeProvider,
              evenementProvider: evenementProvider,
              utilisateurProvider: utilisateurProvider,
              listingCommande: getListingCommande(),
              evenement: evenement!,
              listeView: getInfosArticles(),
              panier: panier,
              validerPaiementFonction: validerPaiement,
              validerRetraitFonction: validerRetrait,
              evenementCloturerFonction: passerEvenementACloturer,
              evenementRetirerFonction: passerEvenementARetirer,
              forcerFinPaiement: forcerFinPaiement,
            ),
    );
  }

  Widget getInfosArticles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: evenement!.articles.map((article) {
        return ResponsiveLayout(
            mobileBody: getInfosArticlesMobile(article),
            desktopBody: getInfosArticlesDesktop(article));
      }).toList(),
    );
  }

  Widget getInfosArticlesMobile(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.nom,
                style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_2),
              ),
              Text(
                article.description,
                style: FontUtils.getFontApp(
                  fontSize: POLICE_MOBILE_NORMAL_2,
                  fontWeight: FONT_WEIGHT_NORMAL,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${article.prix.toStringAsFixed(2)}€",
                    style: FontUtils.getFontApp(
                      fontSize: POLICE_MOBILE_NORMAL_2,
                    ),
                  ),
                  if (utilisateurProvider.perspective == Perspective.PARENT)
                    QuantiteBouton(
                      quantityMax: article.quantiteMax,
                      ajouterArticle: ajouterArticle,
                      retirerArticle: retirerArticle,
                      article: article,
                    ),
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget getInfosArticlesDesktop(Article article) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${article.nom}\n",
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                        ),
                      ),
                      TextSpan(
                        text: article.description,
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                          fontWeight: FONT_WEIGHT_NORMAL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${article.prix.toStringAsFixed(2)}€",
                style: FontUtils.getFontApp(
                  fontSize: POLICE_DESKTOP_NORMAL_2,
                ),
              ),
              if (utilisateurProvider.perspective == Perspective.PARENT)
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 10),
                  child: QuantiteBouton(
                    quantityMax: article.quantiteMax,
                    ajouterArticle: ajouterArticle,
                    retirerArticle: retirerArticle,
                    article: article,
                  ),
                ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  void ajouterArticle(Article article) {
    setState(() {
      panier.ajouterArticle(article);
    });
  }

  void retirerArticle(Article article) {
    setState(() {
      panier.retirerArticle(article);
    });
  }

  Map<String, int> getListingCommande() {
    Map<String, int> listing = {};
    for (Commande commande in evenement!.commandes) {
      for (LigneCommande ligneCommande in commande.listeLigneCommandes) {
        if (listing[ligneCommande.article.nom] == null) {
          listing[ligneCommande.article.nom] = ligneCommande.quantite;
        } else {
          listing[ligneCommande.article.nom] =
              (listing[ligneCommande.article.nom]! + ligneCommande.quantite);
        }
      }
    }
    return listing;
  }
}
