// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view_organisateurs.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view_parents.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class EvenementsViewMobile extends StatelessWidget {
  final Profil profil;

  const EvenementsViewMobile({super.key, required this.profil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(
        titre: "",
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageEvenements(),
              profil == Profil.Parent
                  ? EvenementsViewParents()
                  : EvenementsViewOrganisateur(),
            ],
          )
        ],
      ),
      drawer: DrawerAppli(),
    );
  }
}
