// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EvenementsView extends StatelessWidget {
  static String routeName = '/evenements';

  const EvenementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Liste des événements',
      ),
      body: Column(
        children: [
          ImageEvenements(),
        ],
      ),
      drawer: DrawerGlobal(),
    );
  }
}

class ImageEvenements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          child: Image(
            image: AssetImage("assets/images/casiers.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 160,
          child: Center(
            child: Text(
              "Événements",
              textDirection: TextDirection.ltr,
              style: GoogleFonts.oswald(
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 6,
                      offset: Offset(4, 4),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
