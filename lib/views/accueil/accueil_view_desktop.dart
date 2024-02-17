// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AccueilViewDesktop extends StatelessWidget {
  const AccueilViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Accueil',
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                ImageAccueil(),
                ParagraphePresentation(),
                ParagrapheApplication(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Footer(),
              ],
            ),
          ),
        ],
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
          height: 400,
          width: double.infinity,
          child: Image(
            image: AssetImage("assets/images/ecole.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 400,
          child: Center(
            child: Text(
              "Bienvenue sur \n APE Manager",
              textDirection: TextDirection.ltr,
              style: FontUtils.getOswald(fontSize: 60),
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
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              "Qui sommes nous ?",
              style: FontUtils.getOswald(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Le bureau de l'APEL (Association des parents d'élèves de l'enseignement libre) est composé de six membres élus parmi les parents d'élèves. Tous les parents sont membres de l'APEL et sont les bienvenus aux réunions du CA.",
              style: FontUtils.getOswald(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          Text(
            "L'APEL organise chaque année divers événements pour financer les activités des enfants, y compris des manifestations annuelles comme le marché de Noël et des opérations ponctuelles comme la vente de viennoiseries.",
            style: FontUtils.getOswald(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w300,
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
          padding: EdgeInsets.only(top: 50.0, bottom: 20),
          child: Text(
            "Description de l'application",
            style: FontUtils.getOswald(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "L'application APE Manager vise à organiser des ventes éphémères dans le but de récolter de l'argent qui servira à l'école et aux enfants. Les parents et membres de l'association pourront commander via cette application.",
            style: FontUtils.getOswald(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ]),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 80,
      color: GRIS_FONCE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () =>
                launchUrlString('https://www.saintemarieperenchies.fr/'),
            child: Row(
              children: [
                Image(
                  image: AssetImage("assets/images/logoEcole.png"),
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                      "Site de l'école / collège \nSainte Marie Pérenchies"),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => launchUrlString('https://www.apel.fr/'),
            child: Row(
              children: [
                Image(
                  image: AssetImage("assets/images/APELogo.png"),
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Site de l'APEL national"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
