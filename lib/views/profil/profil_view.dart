import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/profil/popup_ajout_enfant.dart';
import 'package:ape_manager_front/views/profil/popup_modification_enfant.dart';
import 'package:ape_manager_front/views/profil/popup_suppression_enfant.dart';
import 'package:ape_manager_front/views/profil/profil_form_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/tableau.dart';
import 'package:ape_manager_front/widgets/conteneur/tuile.dart';
import 'package:ape_manager_front/widgets/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilView extends StatefulWidget {
  static String routeURL = '/mon-profil';

  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  late UtilisateurProvider utilisateurProvider;
  List<Enfant> enfants = [];

  @override
  void initState() {
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    fetchEnfants();
    super.initState();
  }

  Future<void> fetchEnfants() async {
    await utilisateurProvider.fetchEnfants();
    setState(() {
      enfants = utilisateurProvider.enfants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: getBodyDesktop(context),
      items: [
        BarreNavigationItem(
          titre: "Mon profil",
          label: 'Moi',
          icon: const Icon(Icons.person),
          onglet: getTuileFormulaireProfil(context),
        ),
        BarreNavigationItem(
          titre: "Mon profil",
          label: 'Mes enfants',
          icon: const Icon(Icons.child_care),
          onglet: getTuileTableauEnfants(context),
        ),
      ],
    );
  }

  Widget getBodyDesktop(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          getTitre(context),
          getTuileFormulaireProfil(context),
          getTuileTableauEnfants(context),
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
          "Mon profil",
          textAlign: TextAlign.center,
          style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
        ),
      ),
    );
  }

  Widget getTuileFormulaireProfil(BuildContext context) {
    return Tuile(
      body: ProfilFormView(),
      maxHeight: ResponsiveConstraint.getResponsiveValue(context, 500.0, 300.0),
    );
  }

  Widget getTuileTableauEnfants(BuildContext context) {
    return Tuile(
      maxHeight: 500,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Tableau(
              modele: Enfant(),
              objets: enfants,
              editable: (Enfant enfant) {
                modifierEnfant(context, enfant);
              },
              supprimable: (Enfant enfant) {
                supprimerEnfant(enfant);
              },
            ),
          ),
          if (estMobile(context, 600))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: GRIS_CLAIR),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                          "Restez appuyé pour modifier ou supprimer un enfant",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ),
                ],
              ),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: BoutonAction(
                text: "Ajouter un enfant",
                fonction: () {
                  ajouterEnfant();
                },
                themeCouleur: ThemeCouleur.vert,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ajouterEnfant() {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutEnfant(fetchEnfants: fetchEnfants),
    );
  }

  void modifierEnfant(BuildContext context, Enfant enfant) {
    showDialog(
      context: context,
      builder: (context) =>
          PopupModificationEnfant(enfant: enfant, fetchEnfants: fetchEnfants),
    );
  }

  void supprimerEnfant(Enfant enfant) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopupSuppressionEnfant(
        enfant: enfant,
        fetchEnfants: fetchEnfants,
      ),
    );
  }
}
