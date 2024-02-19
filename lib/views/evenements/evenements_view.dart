// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/evenements/evenements_view_desktop.dart';
import 'package:ape_manager_front/views/evenements/evenements_view_mobile.dart';
import 'package:flutter/material.dart';

class EvenementsView extends StatelessWidget {
  static String routeName = '/evenements';

  const EvenementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: EvenementsViewMobile(
          profil: "Parent",
        ),
        desktopBody: EvenementViewDesktop(
          profil: "Parent",
        ));
  }
}
