import 'package:ape_manager_front/forms/creation_modif_evenement_form.dart';
import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/modification/modifier_evenement_form_view.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_ajout_article.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_ajout_organisateur.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_modifier_article.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_publier_evenement.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_supprimer_article.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_supprimer_evenement.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_supprimer_organisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/tableau.dart';
import 'package:ape_manager_front/widgets/conteneur/tuile.dart';
import 'package:ape_manager_front/widgets/scaffold/page_non_accessible.dart';
import 'package:ape_manager_front/widgets/scaffold/page_vide.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:ape_manager_front/widgets/texte/texte_flexible.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DroitEvenement { aucun, consultation, modification }

class ModifierEvenementView extends StatefulWidget {
  static String routeURL = '/modifier-evenement/:idEvent';
  final int evenementId;

  const ModifierEvenementView({super.key, required this.evenementId});

  @override
  State<ModifierEvenementView> createState() => _ModifierEvenementViewState();
}

class _ModifierEvenementViewState extends State<ModifierEvenementView> {
  late EvenementProvider evenementProvider;
  late UtilisateurProvider utilisateurProvider;
  late CreationModifEvenementForm modifEvenementForm;
  Evenement? evenementBrouillon;
  Map<String, dynamic> valeursInitiales = {};
  DroitEvenement droitEvenement = DroitEvenement.aucun;
  bool chargement = true;

  @override
  void initState() {
    super.initState();
    evenementProvider = Provider.of<EvenementProvider>(context, listen: false);
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    fetchEvenement();
  }

  Future<void> fetchEvenement() async {
    evenementBrouillon = null;
    modifEvenementForm = CreationModifEvenementForm();

    await evenementProvider.fetchEvenement(
      utilisateurProvider.token!,
      widget.evenementId,
    );
    evenementBrouillon = evenementProvider.evenement!;
    valeursInitiales = {
      "titre": evenementBrouillon!.titre,
      "description": evenementBrouillon!.description,
      "dateDebut": evenementBrouillon!.dateDebut,
      "dateFin": evenementBrouillon!.dateFin,
      "dateFinPaiement": evenementBrouillon!.dateFinPaiement,
    };

    await evenementProvider.fetchListeArticles(
      utilisateurProvider.token!,
      evenementBrouillon!,
    );

    if (utilisateurProvider.estAdmin) {
      droitEvenement = DroitEvenement.modification;
    } else if (evenementBrouillon!.proprietaire.email ==
        utilisateurProvider.utilisateur!.email) {
      droitEvenement = DroitEvenement.modification;
    } else if (evenementBrouillon!.organisateurs
        .where((e) => e.email == utilisateurProvider.utilisateur!.email)
        .isNotEmpty) {
      droitEvenement = DroitEvenement.consultation;
    } else {
      droitEvenement = DroitEvenement.aucun;
    }

    setState(() {
      evenementBrouillon;
      droitEvenement;
      chargement = false;
    });

    fetchListeOrganisateurs();
  }

  Future<void> fetchListeOrganisateurs() async {
    await utilisateurProvider
        .fetchListeOrganisateurs(utilisateurProvider.token!);
    setState(() {
      modifEvenementForm.organisateursExistants =
          utilisateurProvider.organisateurs;
      modifEvenementForm.organisateursSelectionnes =
          evenementBrouillon!.organisateurs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chargement) return const PageVide();
    if (droitEvenement == DroitEvenement.aucun) {
      return PageNonAccessible(nomUrlRetour: EvenementsView.routeURL);
    }

    return ScaffoldAppli(
      body: getBodyDesktop(context),
      nomUrlRetour: EvenementsView.routeURL,
      items: [
        BarreNavigationItem(
          titre: droitEvenement == DroitEvenement.modification
              ? "Modification de l'événement"
              : "Consultation de l'événement",
          label: 'Général',
          icon: const Icon(Icons.settings),
          onglet: evenementBrouillon == null
              ? const SizedBox.shrink()
              : getTuileInformationsGenerales(context),
        ),
        BarreNavigationItem(
          titre: droitEvenement == DroitEvenement.modification
              ? "Modification de l'événement"
              : "Consultation de l'événement",
          label: 'Organisateurs',
          icon: const Icon(Icons.person),
          onglet: evenementBrouillon == null
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    getTuileTableauOrganisateurs(context),
                    if (droitEvenement == DroitEvenement.modification)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: BoutonAction(
                            text: "Ajouter un organisateur",
                            fonction: () => afficherPopupAjouterOrganisateur(),
                            themeCouleur: ThemeCouleur.vert,
                            disable:
                                modifEvenementForm.organisateursSelect.isEmpty,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        BarreNavigationItem(
          titre: droitEvenement == DroitEvenement.modification
              ? "Modification de l'événement"
              : "Consultation de l'événement",
          label: 'Articles',
          icon: const Icon(Icons.article),
          onglet: evenementBrouillon == null
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    getTuileTableauArticles(context),
                    if (droitEvenement == DroitEvenement.modification)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: BoutonAction(
                            text: "Ajouter un article",
                            fonction: () => afficherPopupAjouterArticle(),
                            themeCouleur: ThemeCouleur.vert,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        if (droitEvenement == DroitEvenement.modification)
          BarreNavigationItem(
            titre: droitEvenement == DroitEvenement.modification
                ? "Modification de l'événement"
                : "Consultation de l'événement",
            label: 'Validation',
            icon: const Icon(Icons.check),
            onglet: evenementBrouillon == null
                ? const SizedBox.shrink()
                : getRecapitulatifEvenement(context),
          ),
      ],
    );
  }

  Widget getRecapitulatifEvenement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tuile(
          maxHeight: 400,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Récapitulatif de l'événement",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: POLICE_MOBILE_H2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TexteFlexible(
                    texte:
                        "Titre de l'événement : ${evenementBrouillon!.titre}",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TexteFlexible(
                    texte:
                        "Nombre d'organisateurs : ${evenementBrouillon!.organisateurs.length}",
                  ),
                ),
                const TexteFlexible(
                  texte: "Liste des organisateurs :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(), // Thin line added here
                SizedBox(
                  height: 250,
                  // Hauteur fixe pour la liste déroulante des organisateurs
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: evenementBrouillon!.organisateurs.length,
                    itemBuilder: (context, index) {
                      final organisateur =
                          evenementBrouillon!.organisateurs[index];
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title:
                            Text("${organisateur.prenom} ${organisateur.nom}"),
                        subtitle: Text(organisateur.email),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (droitEvenement == DroitEvenement.modification)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                if (evenementBrouillon != null &&
                    evenementBrouillon!.statut == StatutEvenement.BROUILLON)
                  getBoutonPublication(context),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: getBoutonSuppression(context),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget getBodyDesktop(BuildContext context) {
    if (evenementBrouillon == null) return const SizedBox.shrink();
    return SingleChildScrollView(
      child: Column(
        children: [
          getTitre(context),
          getTuileInformationsGenerales(context),
          getTuileTableauOrganisateurs(context),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: getTuileTableauArticles(context),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 800;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (droitEvenement == DroitEvenement.modification)
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: getBoutonSuppression(context),
                        ),
                      if (droitEvenement == DroitEvenement.modification &&
                          evenementBrouillon != null &&
                          evenementBrouillon!.statut ==
                              StatutEvenement.BROUILLON)
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: getBoutonPublication(context),
                        ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getTitre(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          droitEvenement == DroitEvenement.modification
              ? "Modification de l'événement"
              : "Consultation de l'événement",
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
        ),
      ),
    );
  }

  Widget getTuileInformationsGenerales(BuildContext context) {
    return Tuile(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TexteFlexible(
              texte: "Informations générales",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ModifierEvenementFormView(
            evenement: evenementBrouillon!,
            annulerModificationsInfosGenerales: () =>
                annulerModificationsInfosGenerales(),
            modifierInfosGenerales: modifierInfosGenerales,
            droitEvenement: droitEvenement,
          ),
        ],
      ),
      maxHeight:
          ResponsiveConstraint.getResponsiveValue(context, 1000.0, 700.0),
    );
  }

  Widget getTuileTableauOrganisateurs(BuildContext context) {
    return Tuile(
      maxHeight: estDesktop(context, 600) ? 650 : 550,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TexteFlexible(
                    texte: "Liste des organisateurs",
                    style: FontUtils.getFontApp(
                      fontSize: ResponsiveConstraint.getResponsiveValue(
                          context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tableau(
                  nomTableau: "un organisateur",
                  tailleTableau: estDesktop(context, 600) ? 300 : 200,
                  modele: Organisateur(),
                  objets: evenementBrouillon!.organisateurs,
                  supprimable: droitEvenement != DroitEvenement.modification
                      ? null
                      : (Organisateur organisateur) {
                          afficherPopupSupprimerOrganisateur(organisateur);
                        },
                ),
                if (estDesktop(context, 600) &&
                    droitEvenement == DroitEvenement.modification)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: BoutonAction(
                        text: "Ajouter un organisateur",
                        fonction: () => afficherPopupAjouterOrganisateur(),
                        themeCouleur: ThemeCouleur.vert,
                        disable: modifEvenementForm.organisateursSelect.isEmpty,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getTuileTableauArticles(BuildContext context) {
    return Tuile(
      maxHeight: estDesktop(context, 600) ? 650 : 550,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TexteFlexible(
                    texte: "Liste des articles",
                    style: FontUtils.getFontApp(
                      fontSize: ResponsiveConstraint.getResponsiveValue(
                          context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tableau(
                  nomTableau: "un article",
                  tailleTableau: estDesktop(context, 600) ? 450 : 350,
                  modele: Article(),
                  objets: evenementBrouillon!.articles,
                  editable: droitEvenement != DroitEvenement.modification
                      ? null
                      : (Article article) =>
                          afficherPopupModifierArticle(article),
                  supprimable: droitEvenement != DroitEvenement.modification
                      ? null
                      : (Article article) =>
                          afficherPopupSupprimerArticle(article),
                ),
                if (estDesktop(context, 600) &&
                    droitEvenement == DroitEvenement.modification)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: BoutonAction(
                        text: "Ajouter un article",
                        fonction: () {
                          afficherPopupAjouterArticle();
                        },
                        themeCouleur: ThemeCouleur.vert,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Publication événement
  Widget getBoutonPublication(BuildContext context) {
    return BoutonAction(
      text: "Publier l'événement",
      fonction: () {
        if (evenementBrouillon!.titre != valeursInitiales["titre"] ||
            evenementBrouillon!.description !=
                valeursInitiales["description"] ||
            evenementBrouillon!.dateDebut != valeursInitiales["dateDebut"] ||
            evenementBrouillon!.dateFin != valeursInitiales["dateFin"] ||
            evenementBrouillon!.dateFinPaiement !=
                valeursInitiales["dateFinPaiement"]) {
          afficherMessageInfo(
            context: context,
            message:
                "Veuillez enregistrer les modifications effectuées avant de publier le formulaire.",
            duree: 4,
          );
          return;
        }

        if (evenementBrouillon!.titre == "" ||
            evenementBrouillon!.description == "" ||
            evenementBrouillon!.dateDebut == null ||
            evenementBrouillon!.dateFin == null ||
            evenementBrouillon!.dateFinPaiement == null) {
          afficherMessageInfo(
            context: context,
            message:
                "Veuillez renseigner l'intégralité des informations générales avant de publier l'événement.",
            duree: 4,
          );
          return;
        }

        showDialog(
          context: context,
          builder: (context) => PopupPublierModifications(
            publierEvenement: () => futurePublierEvenement(),
            evenement: evenementBrouillon!,
          ),
        );
      },
      themeCouleur: ThemeCouleur.vert,
    );
  }

  Future<void> futurePublierEvenement() async {
    final response = await evenementProvider.publierEvenement(
      utilisateurProvider.token!,
      evenementBrouillon!,
    );

    if (response["statusCode"] == 204 && mounted) {
      revenirEnArriere(context);
      naviguerVersPage(context, EvenementsView.routeURL);
      afficherMessageSucces(context: context, message: response["message"]);
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }

  /// Suppression de l'événement
  Widget getBoutonSuppression(BuildContext context) {
    return BoutonAction(
      text: "Supprimer l'événement",
      fonction: () {
        showDialog(
          context: context,
          builder: (context) => PopupSupprimerEvenement(
            evenement: evenementBrouillon!,
            supprimerEvenement: () => futureSupprimerEvenement(),
          ),
        );
      },
      themeCouleur: ThemeCouleur.rouge,
    );
  }

  Future<void> futureSupprimerEvenement() async {
    final response = await evenementProvider.supprimerEvenement(
      utilisateurProvider.token!,
      evenementBrouillon!,
    );

    if (response["statusCode"] == 204 && mounted) {
      naviguerVersPage(context, EvenementsView.routeURL);
      revenirEnArriere(context);
      afficherMessageSucces(context: context, message: response["message"]);
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }

  /// Ajout d'un organisateur
  void afficherPopupAjouterOrganisateur() {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutOrganisateur(
        organisateursSelect: modifEvenementForm.organisateursSelect,
        ajouterOrganisateur: (Organisateur organisateur) =>
            futureAjouterOrganisateur(organisateur),
      ),
    );
  }

  Future<void> futureAjouterOrganisateur(Organisateur organisateur) async {
    final response = await evenementProvider.ajouterOrganisateur(
      utilisateurProvider.token!,
      evenementBrouillon!,
      organisateur,
    );

    if (response["statusCode"] == 200 && mounted) {
      setState(() {
        evenementBrouillon!.organisateurs.add(organisateur);
      });
      afficherMessageSucces(context: context, message: response["message"]);
      revenirEnArriere(context);
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }

  /// Suppression d'un organisateur
  void afficherPopupSupprimerOrganisateur(Organisateur organisateur) {
    showDialog(
      context: context,
      builder: (context) => PopupSupprimerOrganisateur(
        supprimerOrganisateur: (Organisateur organisateur) =>
            futureSupprimerOrganisateur(organisateur),
        organisateur: organisateur,
      ),
    );
  }

  Future<void> futureSupprimerOrganisateur(Organisateur organisateur) async {
    final response = await evenementProvider.supprimerOrganisateur(
      utilisateurProvider.token!,
      evenementBrouillon!,
      organisateur,
    );

    if (response["statusCode"] == 200 && mounted) {
      setState(() {
        evenementBrouillon!.organisateurs.remove(organisateur);
      });
      afficherMessageSucces(context: context, message: response["message"]);
      revenirEnArriere(context);
    } else {
      afficherMessageInfo(context: context, message: response["message"]);
      if (response["statusCode"] == 409) revenirEnArriere(context);
    }
  }

  /// Ajout d'un article
  void afficherPopupAjouterArticle() {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutArticle(
        ajouterArticle: (Article article) => futureAjouterArticle(article),
      ),
    );
  }

  Future<void> futureAjouterArticle(Article article) async {
    if (article.quantiteMax == 0) article.quantiteMax = -1;
    final response = await evenementProvider.ajouterArticle(
      utilisateurProvider.token!,
      evenementBrouillon!,
      article,
    );

    if (response["statusCode"] == 201 && mounted) {
      setState(() {
        article.id = response["id"];
        evenementBrouillon!.articles.add(article);
      });
      afficherMessageSucces(context: context, message: response["message"]);
      revenirEnArriere(context);
    } else {
      afficherMessageInfo(context: context, message: response["message"]);
    }
  }

  /// Modification d'un article
  void afficherPopupModifierArticle(Article article) {
    showDialog(
      context: context,
      builder: (context) => PopupModifierArticle(
        modifierArticle: (Article article) => futureModifierArticle(article),
        article: article,
      ),
    );
  }

  Future<void> futureModifierArticle(Article article) async {
    if (article.quantiteMax == 0) article.quantiteMax = -1;
    final response = await evenementProvider.modifierArticle(
      utilisateurProvider.token!,
      evenementBrouillon!,
      article,
    );

    if (response["statusCode"] == 200 && mounted) {
      setState(() {
        evenementBrouillon;
      });
      afficherMessageSucces(context: context, message: response["message"]);
      revenirEnArriere(context);
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }

  /// Suppression d'un article
  void afficherPopupSupprimerArticle(Article article) {
    showDialog(
      context: context,
      builder: (context) => PopupSupprimerArticle(
        supprimerArticle: (Article article) => futureSupprimerArticle(article),
        article: article,
      ),
    );
  }

  Future<void> futureSupprimerArticle(Article article) async {
    final response = await evenementProvider.supprimerArticle(
      utilisateurProvider.token!,
      evenementBrouillon!,
      article,
    );

    if (response["statusCode"] == 204 && mounted) {
      setState(() {
        evenementBrouillon!.articles.remove(article);
      });
      afficherMessageSucces(context: context, message: response["message"]);
      revenirEnArriere(context);
    } else {
      afficherMessageInfo(context: context, message: response["message"]);
    }
  }

  /// Annulation des modifications des infos générales
  annulerModificationsInfosGenerales() {
    revenirEnArriere(context);
    setState(() {
      evenementBrouillon!.titre = valeursInitiales["titre"];
      evenementBrouillon!.description = valeursInitiales["description"];
      evenementBrouillon!.dateDebut = valeursInitiales["dateDebut"];
      evenementBrouillon!.dateFin = valeursInitiales["dateFin"];
      evenementBrouillon!.dateFinPaiement = valeursInitiales["dateFinPaiement"];
    });
  }

  /// Modification des infos générales
  modifierInfosGenerales(Evenement evenement) {
    futureModifierInfosGenerales(evenement);
  }

  Future<void> futureModifierInfosGenerales(Evenement evenement) async {
    final response = await evenementProvider.modifierEvenement(
      utilisateurProvider.token!,
      evenement,
    );

    if (response["statusCode"] == 200 && mounted) {
      afficherMessageSucces(context: context, message: response["message"]);
      valeursInitiales = {
        "titre": evenementBrouillon!.titre,
        "description": evenementBrouillon!.description,
        "dateDebut": evenementBrouillon!.dateDebut,
        "dateFin": evenementBrouillon!.dateFin,
        "dateFinPaiement": evenementBrouillon!.dateFinPaiement,
      };
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }
}
