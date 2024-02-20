// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/desktop/evenements_view_organisateurs.dart';
import 'package:ape_manager_front/views/evenements/desktop/evenements_view_parents.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
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
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageEvenements(),
                      profil == "Parent"
                          ? ParentDesktopView()
                          : OrganisateurDesktopView(),
                    ],
                  ),
                ),
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
