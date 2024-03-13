import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/views/commandes/details/bouton_quantite_commandes.dart';
import 'package:ape_manager_front/views/commandes/details/pop_up_suppression_commande.dart';
import 'package:ape_manager_front/views/commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';

class CommandeView extends StatefulWidget {
  static String routeURL = '/commandes/:idCommande';
  final int idCommande;

  CommandeView({super.key, required this.idCommande});

  @override
  State<CommandeView> createState() => _CommandeViewState();
}

class _CommandeViewState extends State<CommandeView> {
  Panier panier = Panier();
  Panier panierInitial = Panier();
  late Commande commandeInitial;
  bool disabledQuantite = true;

  Commande commande = Commande(
    id: 1,
    estPaye: false,
    dateRetrait: DateTime.now(),
    lieuRetrait: "École primaire",
    statut: StatutCommande.VALIDEE,
    libelleEvenement: "Opération chocolat",
  );

  @override
  void initState() {
    super.initState();
    List<Article> listeArticles = [];
    commande.listeLigneCommandes.forEach((ligneCommande) {
      for (int i = 0; i < ligneCommande.quantite; i++) {
        listeArticles.add(ligneCommande.article);
      }
    });
    panier.articles = listeArticles;
    panierInitial = Panier.copie(panier);
    commandeInitial = Commande.copie(commande);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: getDetailCommande(context),
    );
  }

  Widget getDetailCommande(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BoutonRetour(nomUrlRetour: MesCommandesView.routeURL),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: ResponsiveConstraint.getResponsiveValue(
                      context, 20.0, 0.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getNumeroCommande(context),
                  getLibelleEvenement(context),
                  getStatutCommande(context),
                  const Divider(thickness: 0.5),
                  ...commande.listeLigneCommandes.map((ligneCommande) {
                    return getInfosArticles(context, ligneCommande);
                  }).toList(),
                  getPrixTotal(context),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: getBouton(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getNumeroCommande(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Commande n°${commande.id}",
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
      ),
    );
  }

  Widget getLibelleEvenement(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        commande.libelleEvenement,
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2)),
      ),
    );
  }

  Widget getStatutCommande(BuildContext context) {
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
              text: commande.getStatut(),
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                color: commande.getStatut() == "Annulé"
                    ? GRIS_CLAIR
                    : const Color.fromRGBO(0, 86, 27, 100),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getInfosArticles(BuildContext context, LigneCommande ligneCommande) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ResponsiveLayout(
            mobileBody: getArticleInfoMobile(ligneCommande),
            desktopBody: getArticleInfoDesktop(ligneCommande))
      ],
    );
  }

  Widget getArticleInfoMobile(LigneCommande ligneCommande) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ligneCommande.article.nom,
                style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_2),
              ),
              Text(
                ligneCommande.article.description,
                style: FontUtils.getFontApp(
                  fontSize: POLICE_MOBILE_NORMAL_2,
                  fontWeight: FONT_WEIGHT_NORMAL,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${ligneCommande.article.prix.toStringAsFixed(2)}€",
                    style: FontUtils.getFontApp(
                      fontSize: POLICE_MOBILE_NORMAL_2,
                    ),
                  ),
                  QuantiteBoutonCommande(
                    ligneCommande: ligneCommande,
                    ajouterArticle: ajouterArticle,
                    retirerArticle: retirerArticle,
                    augmenterQuantite: augmenterQuantite,
                    diminuerQuantite: diminuerQuantite,
                    disabled: disabledQuantite,
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

  Widget getArticleInfoDesktop(LigneCommande ligneCommande) {
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
                        text: "${ligneCommande.article.nom}\n",
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                        ),
                      ),
                      TextSpan(
                        text: ligneCommande.article.description,
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
                "${ligneCommande.article.prix.toStringAsFixed(2)}€",
                style: FontUtils.getFontApp(
                  fontSize: POLICE_DESKTOP_NORMAL_2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 10),
                child: QuantiteBoutonCommande(
                  ligneCommande: ligneCommande,
                  ajouterArticle: ajouterArticle,
                  retirerArticle: retirerArticle,
                  augmenterQuantite: augmenterQuantite,
                  diminuerQuantite: diminuerQuantite,
                  disabled: disabledQuantite,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget getBouton(BuildContext context) {
    if (commande.getStatut() == "Validé et non payé") {
      return ResponsiveLayout(
        mobileBody: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              BoutonAction(
                text: disabledQuantite ? "Modifier ma commande" : "Sauvegarder",
                fonction: () {
                  if (disabledQuantite) {
                    switchEtatAfficherQuantite();
                  } else {
                    afficherLogCritical("A implémenter");
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: BoutonAction(
                  text: disabledQuantite ? "Supprimer ma commande" : "Annuler",
                  fonction: () {
                    if (!disabledQuantite) {
                      switchEtatAfficherQuantite();
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              PopupSuppressionCommande());
                    }
                  },
                  themeCouleur: ThemeCouleur.rouge,
                ),
              ),
            ],
          ),
        ),
        desktopBody: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoutonAction(
              text: disabledQuantite ? "Modifier ma commande" : "Sauvegarder",
              fonction: () {
                if (disabledQuantite) {
                  switchEtatAfficherQuantite();
                } else {
                  afficherLogCritical("A implémenter");
                }
              },
            ),
            BoutonAction(
              text: disabledQuantite ? "Supprimer ma commande" : "Annuler",
              fonction: () {
                if (!disabledQuantite) {
                  switchEtatAfficherQuantite();
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          PopupSuppressionCommande());
                }
              },
              themeCouleur: ThemeCouleur.rouge,
            ),
          ],
        ),
      );
    }
    if (commande.getStatut() == "À retirer") {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoutonAction(
            text: "Retirer ma commande",
            fonction: null,
          ),
        ],
      );
    }
    if (commande.getStatut() == "Retirée" ||
        commande.getStatut() == "Terminée") {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoutonAction(
            text: "Voir ma facture",
            fonction: null,
          ),
        ],
      );
    }
    return Container();
  }

  void switchEtatAfficherQuantite() {
    setState(() {
      disabledQuantite = !disabledQuantite;
      if (disabledQuantite) {
        panier = Panier.copie(panierInitial);
        commande = Commande.copie(commandeInitial);
      }
    });
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

  void augmenterQuantite(LigneCommande ligneCommande) {
    setState(() {
      ligneCommande.quantite++;
    });
  }

  void diminuerQuantite(LigneCommande ligneCommande) {
    setState(() {
      if (ligneCommande.quantite > 0) ligneCommande.quantite--;
    });
  }
}
