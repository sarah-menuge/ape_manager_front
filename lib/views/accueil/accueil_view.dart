// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/scaffold_appli.dart';
import 'package:flutter/material.dart';

class AccueilView extends StatelessWidget {
  static String routeName = '/accueil';

  const AccueilView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ImageAccueil(),
            ParagraphePresentation(),
            ParagrapheApplication(),
          ],
        ),
      ),
    );
  }
}

class ImageAccueil extends StatelessWidget {
  const ImageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:
              ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          width: double.infinity,
          child: Image(
            image: AssetImage("assets/images/ecole.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height:
              ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          child: Center(
            child: Text(
              "Bienvenue sur \n APE Manager",
              textDirection: TextDirection.ltr,
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ParagraphePresentation extends StatelessWidget {
  const ParagraphePresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          // Titre "Qui sommes nous ?"
          Padding(
            padding: EdgeInsets.symmetric(
              vertical:
                  ResponsiveConstraint.getResponsiveValue(context, 10.0, 20.0),
            ),
            child: Text(
              "Qui sommes nous ?",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Le bureau de l'APEL (Association des parents d'élèves de l'enseignement libre) est composé de six membres élus parmi les parents d'élèves. Tous les parents sont membres de l'APEL et sont les bienvenus aux réunions du CA.",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                fontWeight: ResponsiveConstraint.getResponsiveValue(
                    context, FontWeight.w200, FontWeight.w300),
              ),
            ),
          ),

          Text(
            "L'APEL organise chaque année divers événements pour financer les activités des enfants, y compris des manifestations annuelles comme le marché de Noël et des opérations ponctuelles comme la vente de viennoiseries.",
            style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
              fontWeight: ResponsiveConstraint.getResponsiveValue(
                  context, FontWeight.w200, FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}

class ParagrapheApplication extends StatelessWidget {
  const ParagrapheApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(children: [
        Padding(
          padding: ResponsiveConstraint.getResponsiveValue(
            context,
            EdgeInsets.zero,
            EdgeInsets.only(top: 40.0, bottom: 20),
          ),
          child: Text(
            "Description de l'application",
            style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "L'application APE Manager vise à organiser des ventes éphémères dans le but de récolter de l'argent qui servira à l'école et aux enfants. Les parents et membres de l'association pourront commander via cette application.",
            style: FontUtils.getFontApp(
              fontSize: ResponsiveConstraint.getResponsiveValue(
                  context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
              fontWeight: ResponsiveConstraint.getResponsiveValue(
                  context, FontWeight.w200, FontWeight.w300),
            ),
          ),
        )
      ]),
    );
  }
}
