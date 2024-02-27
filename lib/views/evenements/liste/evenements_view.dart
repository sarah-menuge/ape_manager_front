import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/views/evenements/liste/image_evenements.dart';
import 'package:ape_manager_front/views/evenements/liste/widget_evenement.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:ape_manager_front/widgets/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Profil { Parent, Organisateur, Administrateur }

enum TypeBouton { Detail, Notification, Modifier }

class EvenementsView extends StatefulWidget {
  static String routeName = '/evenements';

  const EvenementsView({super.key});

  @override
  State<EvenementsView> createState() => _EvenementsViewState();
}

class _EvenementsViewState extends State<EvenementsView> {
  static Profil profil = Profil.Organisateur;
  final EvenementProvider evenementProvider = EvenementProvider();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await evenementProvider.fetchData();
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
            profil == Profil.Parent
                ? getVueParents(evenementsEnCours, evenementsAVenir)
                : getVueOrganisateur(evenementsBrouillon, evenementsAVenir,
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
              String formattedDateDebut =
                  DateFormat("dd/MM/yyyy").format(evenement.dateDebut);
              String formattedDateFin =
                  DateFormat("dd/MM/yyyy").format(evenement.dateFin);
              return ListTile(
                title: WidgetEvenement(
                    titreEvenement: evenement.titre,
                    dateDebut: formattedDateDebut,
                    dateFin: formattedDateFin,
                    description: evenement.description,
                    typeBouton: TypeBouton.Detail),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements à venir",
          listeWidget: [
            ...evenementsAVenir.map((evenement) {
              String formattedDateDebut =
                  DateFormat("dd/MM/yyyy").format(evenement.dateDebut);
              String formattedDateFin =
                  DateFormat("dd/MM/yyyy").format(evenement.dateFin);
              return ListTile(
                title: WidgetEvenement(
                    titreEvenement: evenement.titre,
                    dateDebut: formattedDateDebut,
                    dateFin: formattedDateFin,
                    description: evenement.description,
                    typeBouton: TypeBouton.Notification),
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
          ),
          child: ButtonAppli(
            text: "Créer un événement",
            background: BOUTON_CREATION,
            foreground: BLANC,
            routeName: "",
          ),
        ),
        ExpansionTileAppli(
          titre: "Événéments brouillons",
          listeWidget: [
            ...evenementsBrouillon.map((evenement) {
              String formattedDateDebut =
                  DateFormat("dd/MM/yyyy").format(evenement.dateDebut);
              String formattedDateFin =
                  DateFormat("dd/MM/yyyy").format(evenement.dateFin);
              return ListTile(
                title: WidgetEvenement(
                    titreEvenement: evenement.titre,
                    dateDebut: formattedDateDebut,
                    dateFin: formattedDateFin,
                    description: evenement.description,
                    typeBouton: TypeBouton.Modifier),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événéments à venir",
          listeWidget: [
            ...evenementsAVenir.map((evenement) {
              String formattedDateDebut =
                  DateFormat("dd/MM/yyyy").format(evenement.dateDebut);
              String formattedDateFin =
                  DateFormat("dd/MM/yyyy").format(evenement.dateFin);
              return ListTile(
                title: WidgetEvenement(
                    titreEvenement: evenement.titre,
                    dateDebut: formattedDateDebut,
                    dateFin: formattedDateFin,
                    description: evenement.description,
                    typeBouton: TypeBouton.Modifier),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événéments en cours",
          listeWidget: [
            ...evenementsEnCours.map((evenement) {
              String formattedDateDebut =
                  DateFormat("dd/MM/yyyy").format(evenement.dateDebut);
              String formattedDateFin =
                  DateFormat("dd/MM/yyyy").format(evenement.dateFin);
              return ListTile(
                title: WidgetEvenement(
                    titreEvenement: evenement.titre,
                    dateDebut: formattedDateDebut,
                    dateFin: formattedDateFin,
                    description: evenement.description,
                    typeBouton: TypeBouton.Detail),
              );
            }).toList()
          ],
        ),
        ExpansionTileAppli(
          titre: "Événements clôturés",
          expanded: false,
          listeWidget: [
            ...evenementsCloture.map((evenement) {
              String formattedDateDebut =
                  DateFormat("dd/MM/yyyy").format(evenement.dateDebut);
              String formattedDateFin =
                  DateFormat("dd/MM/yyyy").format(evenement.dateFin);
              return ListTile(
                title: WidgetEvenement(
                    titreEvenement: evenement.titre,
                    dateDebut: formattedDateDebut,
                    dateFin: formattedDateFin,
                    description: evenement.description,
                    typeBouton: TypeBouton.Detail),
              );
            }).toList()
          ],
        ),
      ],
    );
  }
}
