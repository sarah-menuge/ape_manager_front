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
import 'package:ape_manager_front/views/evenements/details/bouton_quantite.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement.dart';
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
  Panier panier = Panier();
  late UtilisateurProvider utilisateurProvider;
  Evenement? evenement;

  final EvenementProvider evenementProvider = EvenementProvider();
  final CommandeProvider commandeProvider = CommandeProvider();

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    fetchEvenement();
  }

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
    });
  }

  Future<void> fetchListeArticles() async {
    await evenementProvider.fetchListeArticles(
      utilisateurProvider.token!,
      evenement!,
    );
  }

  Future<void> fetchListeCommandes() async {
    await evenementProvider.fetchListeCommandes(
      utilisateurProvider.token!,
      evenement!,
    );
  }

  /// Passage d'un événement à l'état retrait
  Future<void> passerEvenementARetirer(int idEvenement) async {
    final response = await evenementProvider.passerEvenementEnRetrait(
        utilisateurProvider.token!, idEvenement);
    final response_commande = await commandeProvider.passerCommandeEnRetrait(
        utilisateurProvider.token!, idEvenement);
    if (response["statusCode"] != 204 && mounted) {
      if (response_commande["statusCode"] != 204 && mounted) {
        afficherMessageErreur(
            context: context, message: response_commande["message"]);
      }
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      setState(() {
        evenement!.statut = StatutEvenement.RETRAIT;
        for (Commande commande in evenement!.commandes) {
          commande.statut = StatutCommande.A_RETIRER;
        }
      });
    }
  }

  /// Passage d'un événement à l'état clôturé
  Future<void> passerEvenementACloturer(int idEvenement) async {
    final response = await evenementProvider.passerEvenementEnCloture(
        utilisateurProvider.token!, idEvenement);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      setState(() {
        evenement!.statut = StatutEvenement.CLOTURE;
      });
    }
  }

  /// Forcer la fin de paiement d'un événement
  Future<void> forcerFinPaiement(int idEvenement) async {
    final response = await evenementProvider.annulerCommandeNonPayees(
        utilisateurProvider.token!, idEvenement);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      for (Commande commande in evenement!.commandes) {
        if (commande.estPaye == false) {
          setState(() {
            commande.statut = StatutCommande.ANNULEE;
          });
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

  /// Passage d'une commande à l'état payée
  Future<void> passerCommandeAPayer(int idCommande) async {
    final response = await commandeProvider.passerCommandePayee(
        utilisateurProvider.token!, idCommande);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      for (Commande commande in evenement!.commandes) {
        if (commande.id == idCommande) {
          setState(() {
            commande.statut = StatutCommande.VALIDEE;
            commande.estPaye = true;
          });
        }
      }
    }
  }

  /// Passage d'une commande à l'état retirée
  Future<void> passerCommandeARetirer(int idCommande) async {
    final response = await commandeProvider.passerCommandeRetiree(
        utilisateurProvider.token!, idCommande);
    final response_2 = await commandeProvider.cloturerCommande(
        utilisateurProvider.token!, idCommande);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      for (Commande commande in evenement!.commandes) {
        if (commande.id == idCommande) {
          setState(() {
            commande.statut = StatutCommande.CLOTUREE;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: evenement == null
          ? const SizedBox()
          : DetailEvenementWidget(
              listingCommande: getListingCommande(),
              commandeRetraitFonction: passerCommandeARetirer,
              commandePayerFonction: passerCommandeAPayer,
              evenementCloturerFonction: passerEvenementACloturer,
              evenementRetirerFonction: passerEvenementARetirer,
              forcerFinPaiement: forcerFinPaiement,
              evenementProvider: evenementProvider,
              utilisateurProvider: utilisateurProvider,
              evenement: evenement!,
              listeView: getInfosArticles(),
              panier: panier,
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
