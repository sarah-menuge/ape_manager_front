import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/views/evenements/liste/image_evenements.dart';
import 'package:ape_manager_front/views/evenements/liste/widget_evenement.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:ape_manager_front/widgets/scaffold_appli.dart';
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Evenement> evenementsBrouillon =
        evenementProvider.getEvenementsBrouillon();
    List<Evenement> evenementsAVenir = evenementProvider.getEvenementsAVenir();
    List<Evenement> evenementsEnCours =
        evenementProvider.getEvenementsEnCours();
    List<Evenement> evenementsCloture =
        evenementProvider.getEvenementsCloture();

    return ScaffoldAppli(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageEvenements(),
            if (roleUtilisateur == RoleUtilisateur.parent)
              getVueParents(evenementsEnCours, evenementsAVenir),
            // TODO remplacer le if quand le token sera prit en compte
            // if (roleUtilisateur == RoleUtilisateur.organisateur)
            if (roleUtilisateur != RoleUtilisateur.parent)
              getVueOrganisateur(evenementsBrouillon, evenementsAVenir,
                  evenementsEnCours, evenementsCloture),
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
            ...evenementsEnCours.map((evenement) {
              return ListTile(
                title: WidgetEvenement(
                    evenement: evenement, typeBouton: TypeBouton.Detail),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements à venir",
          listeWidget: [
            ...evenementsAVenir.map((evenement) {
              return ListTile(
                title: WidgetEvenement(
                    evenement: evenement, typeBouton: TypeBouton.Notification),
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
            child: BoutonNavigation(
              text: "Créer un événement",
              routeName: "",
              themeCouleur: ThemeCouleur.vert,
            ),
          ),
        ),
        ExpansionTileAppli(
          titre: "Événements brouillons",
          listeWidget: [
            ...evenementsBrouillon.map((evenement) {
              return ListTile(
                title: WidgetEvenement(
                    evenement: evenement, typeBouton: TypeBouton.Modifier),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements à venir",
          listeWidget: [
            ...evenementsAVenir.map((evenement) {
              return ListTile(
                title: WidgetEvenement(
                    evenement: evenement, typeBouton: TypeBouton.Modifier),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements en cours",
          listeWidget: [
            ...evenementsEnCours.map((evenement) {
              return ListTile(
                title: WidgetEvenement(
                    evenement: evenement, typeBouton: TypeBouton.Detail),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements clôturés",
          expanded: false,
          listeWidget: [
            ...evenementsCloture.map((evenement) {
              return ListTile(
                title: WidgetEvenement(
                    evenement: evenement, typeBouton: TypeBouton.Detail),
              );
            }).toList()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }
}
