import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/commandes/liste/widget_commande.dart';
import 'package:ape_manager_front/views/commandes/liste/widget_commande_mobile.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:ape_manager_front/widgets/texte/texte_flexible.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MesCommandesView extends StatefulWidget {
  static String routeURL = '/mes-commandes';

  const MesCommandesView({super.key});

  @override
  State<MesCommandesView> createState() => _MesCommandesViewState();
}

class _MesCommandesViewState extends State<MesCommandesView> {
  late UtilisateurProvider utilisateurProvider;
  late CommandeProvider commandeProvider;
  late List<Commande> commandesEnCours = [];
  late List<Commande> commandesPassees = [];

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    commandeProvider = Provider.of<CommandeProvider>(context, listen: false);
    fetchCommandes();
  }

  Future<void> fetchCommandes() async {
    await commandeProvider.fetchCommandes(utilisateurProvider.token!);
    setState(() {
      commandesEnCours = commandeProvider.getCommandesEnCours();
      commandesPassees = commandeProvider.getCommandesPassees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: SingleChildScrollView(
        child: Column(
          children: [
            getImageCommande(context),
            getListeCommandes(context),
          ],
        ),
      ),
    );
  }

  Widget getImageCommande(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:
              ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          width: double.infinity,
          child: const Image(
            image: AssetImage("assets/images/colis.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height:
              ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          child: Center(
            child: Text(
              "Mes commandes",
              textDirection: TextDirection.ltr,
              style: FontUtils.getFontApp(
                color: Colors.white,
                shadows: true,
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, 30.0, 60.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getTitreMesCommandes(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Mes commandes",
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
      ),
    );
  }

  Widget getListeCommandes(BuildContext context) {
    if (!commandeProvider.commandesRecuperees) return const SizedBox();
    return Column(
      children: [
        ExpansionTileAppli(
          titre: "Commandes en cours",
          listeWidget: [
            if (commandesEnCours.isEmpty) getListeVide(),
            for (Commande commande in commandesEnCours)
              ListTile(
                title: ResponsiveLayout(
                    mobileBody: WidgetCommandeMobile(commande: commande),
                    desktopBody: WidgetCommande(commande: commande)),
              ),
          ],
        ),
        ExpansionTileAppli(
          titre: "Commandes passées",
          expanded: false,
          listeWidget: [
            if (commandesPassees.isEmpty) getListeVide(),
            for (Commande commande in commandesPassees)
              ListTile(
                title: ResponsiveLayout(
                    mobileBody: WidgetCommandeMobile(commande: commande),
                    desktopBody: WidgetCommande(commande: commande)),
              )
          ],
        ),
      ],
    );
  }

  Widget getListeVide() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          TexteFlexible(
            dejaContenuDansUnRow: true,
            texte: "Aucune commande",
            textAlign: TextAlign.center,
            style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
              fontWeight: FONT_WEIGHT_NORMAL,
            ),
          ),
        ],
      ),
    );
  }
}
