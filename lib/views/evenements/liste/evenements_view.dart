import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/creation/creer_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/image_evenements.dart';
import 'package:ape_manager_front/views/evenements/liste/widget_evenement.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TypeBouton { Detail, Notification, Modifier }

class EvenementsView extends StatefulWidget {
  static String routeURL = '/evenements';

  const EvenementsView({super.key});

  @override
  State<EvenementsView> createState() => _EvenementsViewState();
}

class _EvenementsViewState extends State<EvenementsView> {
  final EvenementProvider evenementProvider = EvenementProvider();
  late UtilisateurProvider utilisateurProvider;
  late RoleUtilisateur roleUtilisateur;
  late String titre_rappel;
  late DateTime date_rappel;

  List<Evenement> evenementsBrouillon = [];
  List<Evenement> evenementsAVenir = [];
  List<Evenement> evenementsEnCours = [];
  List<Evenement> evenementsCloture = [];

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    roleUtilisateur = utilisateurProvider.utilisateur!.role;
    fetchData();
  }

  Future<void> fetchData() async {
    await evenementProvider.fetchEvenements(utilisateurProvider.token!);
    setState(() {
      evenementsBrouillon = evenementProvider.getEvenementsBrouillon();
      evenementsAVenir = evenementProvider.getEvenementsAVenir();
      evenementsEnCours = evenementProvider.getEvenementsEnCours();
      evenementsCloture = evenementProvider.getEvenementsCloture();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageEvenements(),
            if (utilisateurProvider.perspective == Perspective.PARENT)
              Padding(
                padding: EdgeInsets.only(
                    bottom: ResponsiveConstraint.getResponsiveValue(
                        context, 20.0, 0.0)),
                child: getVueParents(evenementsEnCours, evenementsAVenir),
              ),
            if (utilisateurProvider.perspective == Perspective.ORGANIZER)
              Padding(
                padding: EdgeInsets.only(
                    bottom: ResponsiveConstraint.getResponsiveValue(
                        context, 20.0, 0.0)),
                child: getVueOrganisateur(evenementsBrouillon, evenementsAVenir,
                    evenementsEnCours, evenementsCloture),
              ),
          ],
        ),
      ),
    );
  }

  Widget getVueParents(
      List<Evenement> evenementsEnCours, List<Evenement> evenementsAVenir) {
    return Column(
      children: [
        ExpansionTileAppli(
          titre: "Événements en cours",
          listeWidget: [
            if (evenementsEnCours.isEmpty) afficherAucuneDonnees(),
            if (evenementsEnCours.isNotEmpty)
              ...evenementsEnCours.map((evenement) {
                return ListTile(
                  title: WidgetEvenement(
                      utilisateurProvider: utilisateurProvider,
                      evenement: evenement,
                      typeBouton: TypeBouton.Detail),
                );
              }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements à venir",
          listeWidget: [
            if (evenementsAVenir.isEmpty) afficherAucuneDonnees(),
            if (evenementsAVenir.isNotEmpty)
              ...evenementsAVenir.map((evenement) {
                return ListTile(
                  title: WidgetEvenement(
                    utilisateurProvider: utilisateurProvider,
                    evenement: evenement,
                    typeBouton: TypeBouton.Notification,
                    modifierUtilisateurNotifie: modifierUtilisateurNotifie,
                  ),
                );
              }).toList()
          ],
        ),
      ],
    );
  }

  Widget getVueOrganisateur(
      List<Evenement> evenementsBrouillon,
      List<Evenement> evenementsAVenir,
      List<Evenement> evenementsEnCours,
      List<Evenement> evenementsCloture) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: BoutonNavigationGoRouter(
              text: "Créer un événement",
              routeName: CreerEvenementView.routeURL,
              themeCouleur: ThemeCouleur.vert,
            ),
          ),
        ),
        ExpansionTileAppli(
          titre: "Événements brouillons",
          listeWidget: [
            if (evenementsBrouillon.isEmpty) afficherAucuneDonnees(),
            if (evenementsBrouillon.isNotEmpty)
              ...evenementsBrouillon.map((evenement) {
                return ListTile(
                  title: WidgetEvenement(
                      utilisateurProvider: utilisateurProvider,
                      evenement: evenement,
                      typeBouton: TypeBouton.Modifier),
                );
              }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements à venir",
          listeWidget: [
            if (evenementsAVenir.isEmpty) afficherAucuneDonnees(),
            if (evenementsAVenir.isNotEmpty)
              ...evenementsAVenir.map((evenement) {
                return ListTile(
                  title: WidgetEvenement(
                      utilisateurProvider: utilisateurProvider,
                      evenement: evenement,
                      typeBouton: TypeBouton.Modifier),
                );
              }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements en cours",
          listeWidget: [
            if (evenementsEnCours.isEmpty) afficherAucuneDonnees(),
            if (evenementsEnCours.isNotEmpty)
              ...evenementsEnCours.map((evenement) {
                return ListTile(
                  title: WidgetEvenement(
                      utilisateurProvider: utilisateurProvider,
                      evenement: evenement,
                      typeBouton: TypeBouton.Detail),
                );
              }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements clôturés",
          expanded: false,
          listeWidget: [
            if (evenementsCloture.isEmpty) afficherAucuneDonnees(),
            if (evenementsCloture.isNotEmpty)
              ...evenementsCloture.map((evenement) {
                return ListTile(
                  title: WidgetEvenement(
                      utilisateurProvider: utilisateurProvider,
                      evenement: evenement,
                      typeBouton: TypeBouton.Detail),
                );
              }).toList()
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }

  Widget afficherAucuneDonnees() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Aucun événement à afficher",
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
          ),
        ),
      ),
    );
  }

  void modifierUtilisateurNotifie(int idEvenement, bool utilisateurNotifie) {
    setState(() {
      if (utilisateurNotifie) {
        evenementsAVenir
            .firstWhere((e) => e.id == idEvenement)
            .emailUtilisateursNotification
            .add(utilisateurProvider.utilisateur!.email);
      } else {
        evenementsAVenir
            .firstWhere((e) => e.id == idEvenement)
            .emailUtilisateursNotification
            .remove(utilisateurProvider.utilisateur!.email);
      }
    });
  }
}
