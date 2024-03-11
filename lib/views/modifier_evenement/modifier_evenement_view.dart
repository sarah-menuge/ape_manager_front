import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/views/modifier_evenement/modifier_evenement_form_view.dart';
import 'package:ape_manager_front/views/modifier_evenement/popup_ajout_article.dart';
import 'package:ape_manager_front/views/modifier_evenement/popup_annuler_modifications.dart';
import 'package:ape_manager_front/views/modifier_evenement/popup_publier_evenement.dart';
import 'package:ape_manager_front/views/modifier_evenement/popup_supprimer_article.dart';
import 'package:ape_manager_front/views/modifier_evenement/popup_supprimer_evenement.dart';
import 'package:ape_manager_front/widgets/texte/texte_flexible.dart';
import 'package:flutter/material.dart';

import '../../models/barre_navigation_item.dart';
import '../../models/evenement.dart';
import '../../models/organisateur.dart';
import '../../proprietes/constantes.dart';
import '../../proprietes/couleurs.dart';
import '../../providers/evenement_provider.dart';
import '../../responsive/responsive_layout.dart';
import '../../utils/font_utils.dart';
import '../../widgets/button_appli.dart';
import '../../widgets/conteneur/tableau.dart';
import '../../widgets/conteneur/tuile.dart';
import '../../widgets/scaffold_appli.dart';
import 'popup_ajout_organisateur.dart';
import 'popup_supprimer_organisateur.dart';

class ModifierEvenementView extends StatefulWidget {
  static String routeURL = '/modifier-evenement/:idEvent';
  final int evenementId;

  const ModifierEvenementView({super.key, required this.evenementId});

  @override
  State<ModifierEvenementView> createState() => _ModifierEvenementViewState();
}

class _ModifierEvenementViewState extends State<ModifierEvenementView> {
  late EvenementProvider evenementProvider;

  List<Organisateur> organisateurs = [
    Organisateur(
      id: 1,
      nom: "Dupont",
      prenom: "Jean",
      email: "test@test.com",
    ),
    Organisateur(
      id: 2,
      nom: "Martin",
      prenom: "Sophie",
      email: "sophie.martin@example.com",
    ),
    Organisateur(
      id: 3,
      nom: "Leclerc",
      prenom: "Pierre",
      email: "p.leclerc@example.com",
    ),
    Organisateur(
      id: 4,
      nom: "Dubois",
      prenom: "Marie",
      email: "marie.dubois@example.com",
    ),
    Organisateur(
      id: 5,
      nom: "Lefebvre",
      prenom: "Luc",
      email: "luc.lefebvre@example.com",
    ),
    Organisateur(
      id: 6,
      nom: "Bernard",
      prenom: "Émilie",
      email: "emilie.bernard@example.com",
    ),
    Organisateur(
      id: 7,
      nom: "Thomas",
      prenom: "Nicolas",
      email: "nicolas.thomas@example.com",
    ),
    Organisateur(
      id: 8,
      nom: "Petit",
      prenom: "Anne",
      email: "anne.petit@example.com",
    ),
    Organisateur(
      id: 9,
      nom: "Robert",
      prenom: "Julie",
      email: "julie.robert@example.com",
    ),
    Organisateur(
      id: 10,
      nom: "Richard",
      prenom: "Philippe",
      email: "philippe.richard@example.com",
    ),
    Organisateur(
      id: 11,
      nom: "Durand",
      prenom: "Sylvie",
      email: "sylvie.durand@example.com",
    ),
    Organisateur(
      id: 12,
      nom: "Moreau",
      prenom: "Thomas",
      email: "thomas.moreau@example.com",
    ),
    Organisateur(
      id: 13,
      nom: "Laurent",
      prenom: "Céline",
      email: "celine.laurent@example.com",
    ),
    Organisateur(
      id: 14,
      nom: "Garcia",
      prenom: "David",
      email: "david.garcia@example.com",
    ),
    Organisateur(
      id: 15,
      nom: "Leroy",
      prenom: "Christine",
      email: "christine.leroy@example.com",
    ),
    Organisateur(
      id: 16,
      nom: "Girard",
      prenom: "Antoine",
      email: "antoine.girard@example.com",
    ),
    Organisateur(
      id: 17,
      nom: "Roux",
      prenom: "Isabelle",
      email: "isabelle.roux@example.com",
    ),
    Organisateur(
      id: 18,
      nom: "Fournier",
      prenom: "François",
      email: "francois.fournier@example.com",
    ),
    Organisateur(
      id: 19,
      nom: "Morel",
      prenom: "Marion",
      email: "marion.morel@example.com",
    ),
    Organisateur(
      id: 20,
      nom: "Garnier",
      prenom: "Jean-Pierre",
      email: "jp.garnier@example.com",
    ),
  ];

  List<Article> article = [
    Article(
      id: 1,
      nom: "Article 5",
      description: "Description de l'article 5",
      prix: 50.0,
      quantiteMax: 100,
    ),
    Article(
      id: 2,
      nom: "Article 6",
      description: "Description de l'article 6",
      prix: 60.0,
      quantiteMax: 100,
    ),
    Article(
      id: 3,
      nom: "Article 7",
      description: "Description de l'article 7",
      prix: 70.0,
      quantiteMax: 100,
    ),
    Article(
      id: 4,
      nom: "Article 8",
      description: "Description de l'article 8",
      prix: 80.0,
      quantiteMax: 100,
    ),
    Article(
      id: 5,
      nom: "Article 9",
      description: "Description de l'article 9",
      prix: 90.0,
      quantiteMax: 100,
    ),
    Article(
      id: 6,
      nom: "Article 10",
      description: "Description de l'article 10",
      prix: 100.0,
      quantiteMax: 100,
    ),
  ];

  get titre => null;

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: getBodyDesktop(context),
      items: [
        BarreNavigationItem(
          titre: "Modification d'événement",
          label: 'Général',
          icon: Icon(Icons.settings),
          onglet: getTuileFormulaireTitre(context),
        ),
        BarreNavigationItem(
          titre: "Modification d'événement",
          label: 'Organisateurs',
          icon: Icon(Icons.person),
          onglet: Column(children: [
            getTuileTableauOrganisateurs(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: GRIS_CLAIR),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                          "Restez appuyé pour modifier ou supprimer un organisateur",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: BoutonAction(
                  text: "Ajouter un organisateur",
                  fonction: () {
                    ajouterOrganisateur();
                  },
                  themeCouleur: ThemeCouleur.vert,
                ),
              ),
            ),
          ]),
        ),
        BarreNavigationItem(
          titre: "Modification d'événement",
          label: 'Articles',
          icon: Icon(Icons.article),
          onglet: Column(children: [
            getTuileTableauArticles(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: GRIS_CLAIR),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                          "Restez appuyé pour modifier ou supprimer un article",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: BoutonAction(
                  text: "Ajouter un article",
                  fonction: () {
                    ajouterArticle();
                  },
                  themeCouleur: ThemeCouleur.vert,
                ),
              ),
            ),
          ]),
        ),
        BarreNavigationItem(
            titre: "Modification d'événement",
            label: 'Validation',
            icon: Icon(Icons.check),
            onglet: getRecapitulatifEvenement(context)),
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
                Text(
                  "Récapitulatif de l'événement",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: POLICE_MOBILE_H2,
                  ),
                ),
                Divider(),
                TexteFlexible(
                  texte: "Titre de l'événement: ${titre}",
                ),
                SizedBox(height: 10),
                TexteFlexible(
                  texte: "Nombre d'organisateurs: ${organisateurs.length}",
                ),
                SizedBox(height: 10),
                TexteFlexible(
                  texte: "Liste des organisateurs:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(), // Thin line added here
                Container(
                  height: 300,
                  // Hauteur fixe pour la liste déroulante des organisateurs
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: organisateurs.length,
                    itemBuilder: (context, index) {
                      final organisateur = organisateurs[index];
                      return ListTile(
                        leading: Icon(Icons.person),
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
        SizedBox(height: 20),
        getBoutonPublication(context),
        SizedBox(height: 20),
        getBoutonSuppression(context),
      ],
    );
  }

  Widget getBodyDesktop(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          getTitre(context),
          getTuileFormulaireTitre(context),
          getTuileTableauOrganisateurs(context),
          getTuileTableauArticles(context),
          SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 800;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getBoutonPublication(context),
                      SizedBox(width: 20),
                      getBoutonSuppression(context),
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
          "Modification d'événement",
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
        ),
      ),
    );
  }

  Widget getTuileFormulaireTitre(BuildContext context) {
    return Tuile(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TexteFlexible(
              texte: "Veuillez renseigner les informations de l'événement",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ModifierEvenementFormView(),
          ResponsiveLayout(
            mobileBody:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              getBoutonEnregistrer(context),
              SizedBox(height: 20),
              getBoutonAnnulation(context),
            ]),
            desktopBody:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getBoutonEnregistrer(context),
                SizedBox(width: 20),
                getBoutonAnnulation(context),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      maxHeight:
          ResponsiveConstraint.getResponsiveValue(context, 1000.0, 700.0),
    );
  }

  Widget getTuileTableauOrganisateurs(BuildContext context) {
    return Tuile(
      maxHeight: 500,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TexteFlexible(
                  texte:
                      "Veuillez renseigner la liste des organisateurs de l'événement",
                  style: FontUtils.getFontApp(
                    fontSize: ResponsiveConstraint.getResponsiveValue(
                        context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Tableau(
                  modele: Organisateur(),
                  objets: organisateurs,
                  supprimable: (Organisateur organisateurs) {
                    supprimerOrganisateur(organisateurs);
                  },
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
      maxHeight: 500,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TexteFlexible(
                  texte:
                      "Veuillez renseigner la liste des articles de l'événement",
                  style: FontUtils.getFontApp(
                    fontSize: ResponsiveConstraint.getResponsiveValue(
                        context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Tableau(
                  modele: Article(),
                  objets: article,
                  editable: (Article article) {
                    modifierArticle(article);
                  },
                  supprimable: (Article article) {
                    supprimerArticle(article);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBoutonEnregistrer(BuildContext context) {
    return BoutonAction(
      text: "Enregistrer les modifications",
      fonction: () {
        afficherLogCritical(
            "Fonctionnalité pas encore implémenter = modifier événement");
      },
      themeCouleur: ThemeCouleur.bleu,
    );
  }

  Widget getBoutonAnnulation(BuildContext context) {
    return BoutonAction(
      text: "Annuler les modifications",
      fonction: () {
        showDialog(
          context: context,
          builder: (context) => PopupAnnulerModifications(
              fetchEvenements: () {},
              evenement: Evenement(
                  id: -1,
                  titre: '',
                  lieu: '',
                  dateDebut: DateTime.now(),
                  dateFin: DateTime.now(),
                  finPaiement: false,
                  statut: StatutEvenement.BROUILLON,
                  description: '',
                  proprietaire: Organisateur(),
                  organisateurs: [],
                  articles: [],
                  commandes: [])),
        );
      },
      themeCouleur: ThemeCouleur.rouge,
    );
  }

  Widget getBoutonPublication(BuildContext context) {
    return BoutonAction(
      text: "Publier l'événement",
      fonction: () {
        showDialog(
          context: context,
          builder: (context) => PopupPublierModifications(
              fetchEvenements: () {},
              evenement: Evenement(
                  id: -1,
                  titre: '',
                  lieu: '',
                  dateDebut: DateTime.now(),
                  dateFin: DateTime.now(),
                  finPaiement: false,
                  statut: StatutEvenement.BROUILLON,
                  description: '',
                  proprietaire: Organisateur(),
                  organisateurs: [],
                  articles: [],
                  commandes: [])),
        );
      },
      themeCouleur: ThemeCouleur.vert,
    );
  }

  Widget getBoutonSuppression(BuildContext context) {
    return BoutonAction(
      text: "Supprimer l'événement",
      fonction: () {
        showDialog(
          context: context,
          builder: (context) => PopupSupprimerEvenement(
              fetchEvenements: () {},
              evenement: Evenement(
                  id: -1,
                  titre: '',
                  lieu: '',
                  dateDebut: DateTime.now(),
                  dateFin: DateTime.now(),
                  finPaiement: false,
                  statut: StatutEvenement.BROUILLON,
                  description: '',
                  proprietaire: Organisateur(),
                  organisateurs: [],
                  articles: [],
                  commandes: [])),
        );
      },
      themeCouleur: ThemeCouleur.rouge,
    );
  }

  void doNothing() {}

  void ajouterOrganisateur() {
    showDialog(
      context: context,
      builder: (context) =>
          PopupAjoutOrganisateur(fetchOrganisateurs: doNothing),
    );
  }

  void supprimerOrganisateur(Organisateur organisateur) {
    showDialog(
      context: context,
      builder: (context) => PopupSupprimerOrganisateur(
        fetchOrganisateurs: doNothing,
        organisateur: organisateur,
      ),
    );
  }

  void ajouterArticle() {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutArticle(
        fetchArticles: doNothing,
      ),
    );
  }

  void modifierArticle(Article article) {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutArticle(
        fetchArticles: doNothing,
        article: article,
      ),
    );
  }

  void supprimerArticle(Article article) {
    showDialog(
      context: context,
      builder: (context) => PopupSupprimerArticle(
        fetchArticles: doNothing,
        article: article,
      ),
    );
  }
}
