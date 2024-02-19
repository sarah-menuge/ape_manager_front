// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/views/evenements/mobile/evenements_view_organisateurs.dart';
import 'package:ape_manager_front/views/evenements/mobile/evenements_view_parents.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EvenementsViewMobile extends StatelessWidget {
  final String profil;

  const EvenementsViewMobile({super.key, required this.profil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(
        titre: "Liste des événements",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageEvenements(),
          profil == "Parent" ? ParentMobileView() : OrganisateurMobileView(),
        ],
      ),
      drawer: DrawerAppli(),
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
