// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';

class AccueilViewDesktop extends StatelessWidget {
  const AccueilViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(
        titre: '',
      ),
      body: StickyFooterScrollView(
        footer: Footer(),
        itemBuilder: (BuildContext context, int index) {
          return BodyAccueilView();
        },
        itemCount: 1,
      ),
    );
  }
}

class BodyAccueilView extends StatelessWidget {
  const BodyAccueilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ImageAccueil(),
        ParagraphePresentation(),
        ParagrapheApplication(),
      ],
    );
  }
}
