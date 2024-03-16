import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/views/evenements/creation/creer_evenement_form_view.dart';
import 'package:ape_manager_front/views/evenements/creation/popup_ajout_organisateur.dart';
import 'package:ape_manager_front/views/evenements/creation/popup_supprimer_organisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/tableau.dart';
import 'package:ape_manager_front/widgets/conteneur/tuile.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:ape_manager_front/widgets/texte/texte_flexible.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreerEvenementView extends StatefulWidget {
  static String routeURL = '/creer-evenement';

  const CreerEvenementView({super.key});

  @override
  State<CreerEvenementView> createState() => _CreerEvenementViewState();
}

class _CreerEvenementViewState extends State<CreerEvenementView> {
  late EvenementProvider evenementProvider;

  @override
  void initState() {
    evenementProvider = Provider.of<EvenementProvider>(context, listen: false);
    super.initState();
  }

  List<Organisateur> organisateurs = [
    Organisateur(
      id: 1,
      nom: "Dupont",
      prenom: "Jean",
      email: "test@test.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 2,
      nom: "Martin",
      prenom: "Sophie",
      email: "sophie.martin@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 3,
      nom: "Leclerc",
      prenom: "Pierre",
      email: "p.leclerc@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 4,
      nom: "Dubois",
      prenom: "Marie",
      email: "marie.dubois@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 5,
      nom: "Lefebvre",
      prenom: "Luc",
      email: "luc.lefebvre@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 6,
      nom: "Bernard",
      prenom: "Émilie",
      email: "emilie.bernard@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 7,
      nom: "Thomas",
      prenom: "Nicolas",
      email: "nicolas.thomas@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 8,
      nom: "Petit",
      prenom: "Anne",
      email: "anne.petit@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 9,
      nom: "Robert",
      prenom: "Julie",
      email: "julie.robert@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 10,
      nom: "Richard",
      prenom: "Philippe",
      email: "philippe.richard@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 11,
      nom: "Durand",
      prenom: "Sylvie",
      email: "sylvie.durand@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 12,
      nom: "Moreau",
      prenom: "Thomas",
      email: "thomas.moreau@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 13,
      nom: "Laurent",
      prenom: "Céline",
      email: "celine.laurent@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 14,
      nom: "Garcia",
      prenom: "David",
      email: "david.garcia@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 15,
      nom: "Leroy",
      prenom: "Christine",
      email: "christine.leroy@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 16,
      nom: "Girard",
      prenom: "Antoine",
      email: "antoine.girard@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 17,
      nom: "Roux",
      prenom: "Isabelle",
      email: "isabelle.roux@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 18,
      nom: "Fournier",
      prenom: "François",
      email: "francois.fournier@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 19,
      nom: "Morel",
      prenom: "Marion",
      email: "marion.morel@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
    Organisateur(
      id: 20,
      nom: "Garnier",
      prenom: "Jean-Pierre",
      email: "jp.garnier@example.com",
      telephone: "1",
      role: RoleUtilisateur.organisateur,
      estMembre: true,
    ),
  ];

  String titre = "";

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: getBodyDesktop(context),
      items: [
        BarreNavigationItem(
          titre: "Création d'événement",
          label: 'Général',
          icon: const Icon(Icons.settings),
          onglet: getTuileFormulaireTitre(context),
        ),
        BarreNavigationItem(
          titre: "Création d'événement",
          label: 'Organisateurs',
          icon: const Icon(Icons.person),
          onglet: Column(children: [
            getTuileTableauOrganisateurs(context),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: GRIS_CLAIR),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        "Restez appuyé pour modifier ou supprimer un organisateur",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
          titre: "Création d'événement",
          label: 'Validation',
          icon: const Icon(Icons.check),
          onglet: getRecapitulatifEvenement(context),
        ),
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
          SizedBox(height: 20),
          getBoutonValidation(context),
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
          "Création d'événement",
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
            padding: const EdgeInsets.only(top: 15.0),
            child: TexteFlexible(
              texte: "Veuillez renseigner le titre de l'évenement à créer",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const TexteFlexible(
            texte: "Il sera modifiable plus tard",
            textAlign: TextAlign.center,
          ),
          const CreerEvenementFormView(),
        ],
      ),
      maxHeight: ResponsiveConstraint.getResponsiveValue(context, 500.0, 300.0),
    );
  }

  Widget getTuileTableauOrganisateurs(BuildContext context) {
    return Tuile(
      maxHeight: estDesktop(context, 600) ? 500 : 400,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
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
                const SizedBox(height: 10),
                const TexteFlexible(
                  texte: "Elle sera modifiable plus tard",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Tableau(
                  tailleTableau: estDesktop(context, 600) ? 300 : 200,
                  modele: Organisateur(),
                  objets: organisateurs,
                  editable: (Organisateur organisateurs) {
                    modifierOrganisateur(organisateurs);
                  },
                  supprimable: (Organisateur organisateurs) {
                    supprimerOrganisateur(organisateurs);
                  },
                ),
                //if desktop
                if (estDesktop(context, 600))
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BoutonAction(
                      text: "Ajouter un organisateur",
                      fonction: () {
                        ajouterOrganisateur();
                      },
                      themeCouleur: ThemeCouleur.vert,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBoutonValidation(BuildContext context) {
    return BoutonAction(
      text: "Valider la création",
      fonction: () =>
          afficherLogCritical("Création d'un événement non pris en charge"),
      themeCouleur: ThemeCouleur.vert,
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
                TexteFlexible(
                  texte: "Titre de l'événement : ${titre}",
                ),
                const SizedBox(height: 10),
                TexteFlexible(
                  texte: "Nombre d'organisateurs : ${organisateurs.length}",
                ),
                const SizedBox(height: 10),
                const TexteFlexible(
                  texte: "Liste des organisateurs :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 200,
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
        const SizedBox(height: 20),
        getBoutonValidation(context),
      ],
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

  void modifierOrganisateur(Organisateur organisateur) {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutOrganisateur(
        fetchOrganisateurs: doNothing,
        organisateur: organisateur,
      ),
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
}