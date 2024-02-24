// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view_organisateurs.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view_parents.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';

class EvenementViewDesktop extends StatelessWidget {
  final Profil profil;

  const EvenementViewDesktop({super.key, required this.profil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(
        titre: "",
      ),
      body: StickyFooterScrollView(
        footer: Footer(),
        itemBuilder: (BuildContext context, int index) {
          return BodyEvenementsViewDesktop(profil: profil);
        },
        itemCount: 1,
      ),
    );
  }
}

class BodyEvenementsViewDesktop extends StatelessWidget {
  final Profil profil;

  const BodyEvenementsViewDesktop({super.key, required this.profil});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageEvenements(),
            profil == Profil.Parent
                ? EvenementsViewParents()
                : EvenementsViewOrganisateur(),
          ],
        ),
      ),
    );
  }
}
