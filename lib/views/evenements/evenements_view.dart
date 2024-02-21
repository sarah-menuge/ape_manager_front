// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/evenements_view_desktop.dart';
import 'package:ape_manager_front/views/evenements/evenements_view_mobile.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

enum Profil { Parent, Organisateur }

enum TypeBouton { Detail, Notification, Modifier }

class EvenementsView extends StatelessWidget {
  static String routeName = '/evenements';

  const EvenementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: EvenementsViewMobile(
          profil: Profil.Organisateur,
        ),
        desktopBody: EvenementViewDesktop(
          profil: Profil.Parent,
        ));
  }
}

class ImageEvenements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:
              ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          width: double.infinity,
          child: Image(
            image: AssetImage("assets/images/casiers.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height:
              ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          child: Center(
            child: Text(
              "Événements",
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
}

class EvenementWidget extends StatelessWidget {
  final String periode;
  final String operation;
  final String? lieu;
  final TypeBouton type_button;

  const EvenementWidget({
    super.key,
    required this.periode,
    required this.operation,
    required this.type_button,
    this.lieu,
  });

  Widget EvenementWidgetMobile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              operation,
              style: FontUtils.getFontApp(
                fontSize: 15,
              ),
            ),
            Text(
              periode,
              style: FontUtils.getFontApp(
                fontWeight: FontWeight.w100,
                fontSize: 15,
              ),
            ),
          ],
        ),
        if (type_button == TypeBouton.Detail)
          ButtonAppli(
              text: "Plus de détail",
              background: BLEU,
              foreground: BLANC,
              routeName: ""),
        if (type_button == TypeBouton.Notification)
          ButtonAppli(
              text: "Me notifier",
              background: ROUGE,
              foreground: BLANC,
              routeName: ""),
        if (type_button == TypeBouton.Modifier)
          ButtonAppli(
              text: "Modifier",
              background: ROUGE,
              foreground: BLANC,
              routeName: ""),
      ],
    );
  }

  Widget EvenementWidgetDesktop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          operation,
          style: FontUtils.getFontApp(
            fontSize: 18,
          ),
        ),
        Text(
          periode,
          style: FontUtils.getFontApp(
            fontSize: 18,
          ),
        ),
        if (type_button == TypeBouton.Detail)
          ButtonAppli(
              text: "Plus de détail",
              background: BLEU,
              foreground: BLANC,
              routeName: ""),
        if (type_button == TypeBouton.Notification)
          ButtonAppli(
              text: "Me notifier",
              background: ROUGE,
              foreground: BLANC,
              routeName: ""),
        if (type_button == TypeBouton.Modifier)
          ButtonAppli(
              text: "Modifier",
              background: ROUGE,
              foreground: BLANC,
              routeName: ""),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveConstraint.getResponsiveValue(context, 10.0, 60.0),
      ),
      child: Column(
        children: [
          ListTile(
              title: ResponsiveLayout(
            mobileBody: EvenementWidgetMobile(context),
            desktopBody: EvenementWidgetDesktop(context),
          )),
        ],
      ),
    );
  }
}
