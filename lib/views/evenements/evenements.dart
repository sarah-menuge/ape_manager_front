// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/global/drawer_global.dart';
import 'package:ape_manager_front/views/global/header_global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Evenements extends StatelessWidget {
  const Evenements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Liste des événements',
      ),
      body: Column(
        children: [
          ImageAccueil(),
        ],
      ),
      drawer: DrawerGlobal(),
    );
  }
}

class ImageAccueil extends StatelessWidget {
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
