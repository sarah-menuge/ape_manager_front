// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class AccueilViewMobile extends StatelessWidget {
  const AccueilViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Accueil',
      ),
      body: ListView(
        children: [
          ImageAccueil(),
          ParagraphePresentation(),
          ParagrapheApplication(),
        ],
      ),
      drawer: DrawerGlobal(),
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
          height: 160,
          width: double.infinity,
          child: Image(
            image: AssetImage("assets/images/ecole.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 160,
          child: Center(
            child: Text(
              "Bienvenue sur \n APE Manager",
              textDirection: TextDirection.ltr,
              style: FontUtils.getOswald(),
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
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "Qui sommes nous ?",
              style: FontUtils.getOswald(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Le bureau de l'APEL (Association des parents d'élèves de l'enseignement libre) est composé de six membres élus parmi les parents d'élèves. Tous les parents sont membres de l'APEL et sont les bienvenus aux réunions du CA.",
              style: FontUtils.getOswald(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),

          Text(
            "L'APEL organise chaque année divers événements pour financer les activités des enfants, y compris des manifestations annuelles comme le marché de Noël et des opérations ponctuelles comme la vente de viennoiseries.",
            style: FontUtils.getOswald(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w100,
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
        Text(
          "Description de l'application",
          style: FontUtils.getOswald(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "L'application APE Manager vise à organiser des ventes éphémères dans le but de récolter de l'argent qui servira à l'école et aux enfants. Les parents et membres de l'association pourront commander via cette application.",
            style: FontUtils.getOswald(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
        )
      ]),
    );
  }
}
