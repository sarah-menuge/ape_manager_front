// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class AccueilViewMobile extends StatelessWidget {
  const AccueilViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(),
      body: ListView(
        children: [
          ImageAccueil(),
          ParagraphePresentation(),
          ParagrapheApplication(),
        ],
      ),
      drawer: DrawerAppli(),
    );
  }
}
