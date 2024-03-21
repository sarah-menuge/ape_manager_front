import 'package:ape_manager_front/forms/creation_modif_evenement_form.dart';
import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/evenements/creation/popup_ajout_organisateur.dart';
import 'package:ape_manager_front/views/evenements/creation/popup_suppression_organisateur.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/tableau.dart';
import 'package:ape_manager_front/widgets/conteneur/tuile.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
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
  late CreationModifEvenementForm creationEvenementForm;
  late UtilisateurProvider utilisateurProvider;
  String? erreur;

  @override
  void initState() {
    super.initState();
    evenementProvider = Provider.of<EvenementProvider>(context, listen: false);
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    creationEvenementForm = CreationModifEvenementForm();
    fetchListeOrganisateurs();
  }

  Future<void> fetchListeOrganisateurs() async {
    await utilisateurProvider
        .fetchListeOrganisateurs(utilisateurProvider.token!);
    setState(() {
      creationEvenementForm.organisateursExistants =
          utilisateurProvider.organisateurs;
    });
  }

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
          onglet: Column(
            children: [
              getTuileTableauOrganisateurs(context),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: BoutonAction(
                    text: "Ajouter un organisateur",
                    fonction: () => afficherPopupAjouterOrganisateur(),
                    themeCouleur: ThemeCouleur.vert,
                    disable: creationEvenementForm.organisateursSelect.isEmpty,
                  ),
                ),
              ),
            ],
          ),
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
          Text(
            erreur != null ? erreur! : "",
            style: const TextStyle(color: Colors.red, fontSize: 20.0),
          ),
          getTuileFormulaireTitre(context),
          getTuileTableauOrganisateurs(context),
          const SizedBox(height: 20),
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
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: TexteFlexible(
              texte: "Titre de l'événement à créer",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const TexteFlexible(
            texte: "Il sera modifiable plus tard",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ChampString(
              label: "Titre de l'événement",
              prefixIcon: const Icon(Icons.title),
              onChangedMethod: (value) {
                creationEvenementForm.titreEvenement = value!;
              },
            ),
          ),
        ],
      ),
      maxHeight: ResponsiveConstraint.getResponsiveValue(context, 500.0, 300.0),
    );
  }

  Widget getTuileTableauOrganisateurs(BuildContext context) {
    return Tuile(
      maxHeight: estDesktop(context, 600) ? 700 : 550,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TexteFlexible(
                  texte: "Liste des organisateurs de l'événement",
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
                  nomTableau: "un organisateur",
                  tailleTableau: estDesktop(context, 600) ? 300 : 200,
                  modele: Organisateur(),
                  objets: creationEvenementForm.organisateursSelectionnes,
                  supprimable: (Organisateur o) =>
                      afficherPopupSupprimerOrganisateur(o),
                ),
                //if desktop
                if (estDesktop(context, 600))
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BoutonAction(
                      text: "Ajouter un organisateur",
                      fonction: () => afficherPopupAjouterOrganisateur(),
                      themeCouleur: ThemeCouleur.vert,
                      disable:
                          creationEvenementForm.organisateursSelect.isEmpty,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getRecapitulatifEvenement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tuile(
          maxHeight: 700,
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
                Text(
                  erreur != null ? erreur! : "",
                  style: const TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                const Divider(),
                TexteFlexible(
                  texte:
                      "Titre de l'événement : ${creationEvenementForm.titreEvenement}",
                ),
                const SizedBox(height: 10),
                TexteFlexible(
                  texte:
                      "Nombre d'organisateurs : ${creationEvenementForm.organisateursSelectionnes.length}",
                ),
                const SizedBox(height: 10),
                const TexteFlexible(
                  texte: "Liste des organisateurs :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        creationEvenementForm.organisateursSelectionnes.length,
                    itemBuilder: (context, index) {
                      final organisateur = creationEvenementForm
                          .organisateursSelectionnes[index];
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
        const SizedBox(height: 20),
        getBoutonValidation(context),
      ],
    );
  }

  void afficherPopupAjouterOrganisateur() {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutOrganisateur(
        organisateursSelect: creationEvenementForm.organisateursSelect,
        ajouterOrganisateur: (Organisateur organisateur) {
          setState(() {
            creationEvenementForm.organisateursSelectionnes.add(organisateur);
          });
          revenirEnArriere(context);
        },
      ),
    );
  }

  void afficherPopupSupprimerOrganisateur(Organisateur organisateur) {
    showDialog(
      context: context,
      builder: (context) => PopupSuppressionOrganisateur(
        organisateur: organisateur,
        supprimerOrganisateur: (Organisateur organisateur) {
          setState(() {
            creationEvenementForm.organisateursSelectionnes
                .remove(organisateur);
          });
          revenirEnArriere(context);
        },
      ),
    );
  }

  Widget getBoutonValidation(BuildContext context) {
    return BoutonAction(
      text: "Valider la création",
      themeCouleur: ThemeCouleur.vert,
      fonction: () {
        String? estValide = creationEvenementForm.estValide();
        if (estValide != null) {
          setState(() => erreur = estValide);
          // afficherMessageErreur(context: context, message: estValide);
          return;
        }
        creerEvenement();
      },
    );
  }

  Future<void> creerEvenement() async {
    final response = await evenementProvider.creerEvenement(
      utilisateurProvider.token!,
      creationEvenementForm,
    );

    if (response["statusCode"] == 201 && mounted) {
      setState(() => erreur = null);
      afficherMessageSucces(
        context: context,
        message: response["message"],
      );
      naviguerVersPage(context, EvenementsView.routeURL);
    } else {
      setState(() {
        erreur = response['message'];
        afficherMessageErreur(context: context, message: response['message']);
      });
    }
  }
}
