import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/accueil/accueil_view_desktop.dart';
import 'package:ape_manager_front/views/accueil/accueil_view_mobile.dart';
import 'package:flutter/material.dart';

class AccueilView extends StatelessWidget {
  static String routeName = '/accueil';

  const AccueilView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: AccueilViewMobile(),
      desktopBody: AccueilViewDesktop(),
    );
  }
}
