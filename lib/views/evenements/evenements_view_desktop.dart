// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/desktop/evenements_view_organisateurs.dart';
import 'package:ape_manager_front/views/evenements/desktop/evenements_view_parents.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class EvenementViewDesktop extends StatelessWidget {
  final String profil;

  const EvenementViewDesktop({super.key, required this.profil});

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
          profil == "Parent" ? ParentDesktopView() : OrganisateurDesktopView(),
        ],
      ),
    );
  }
}

class ImageEvenements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          child: Image(
            image: AssetImage("assets/images/casiers.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 400,
          child: Center(
            child: Text(
              "Événements",
              textDirection: TextDirection.ltr,
              style: FontUtils.getFontApp(
                fontSize: 60,
                color: Colors.white,
                shadows: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
