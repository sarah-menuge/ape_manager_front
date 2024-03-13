import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/commandes/liste/widget_commande.dart';
import 'package:ape_manager_front/views/commandes/liste/widget_commande_mobile.dart';
import 'package:ape_manager_front/widgets/expansion_tile_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';

class MesCommandesView extends StatelessWidget {
  static String routeURL = '/mes-commandes';

  const MesCommandesView({super.key});

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
    return const Column(
      children: [
        ExpansionTileAppli(
          titre: "Commandes en cours",
          listeWidget: [
            ListTile(
              title: ResponsiveLayout(
                  mobileBody: WidgetCommandeMobile(),
                  desktopBody: WidgetCommande()),
            ),
          ],
        ),
        ExpansionTileAppli(
          titre: "Commandes passées",
          expanded: false,
          listeWidget: [
            ListTile(
              title: ResponsiveLayout(
                  mobileBody: WidgetCommandeMobile(),
                  desktopBody: WidgetCommande()),
            )
          ],
        ),
      ],
    );
  }
}
