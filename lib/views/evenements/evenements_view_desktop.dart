// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/evenements/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/evenements_view_organisateurs.dart';
import 'package:ape_manager_front/views/evenements/evenements_view_parents.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class EvenementViewDesktop extends StatelessWidget {
  final Profil profil;

  const EvenementViewDesktop({super.key, required this.profil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(
        titre: "Liste des événements",
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Padding(
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
            ],
          ),
          Footer(),
        ],
      ),
    );
  }
}
