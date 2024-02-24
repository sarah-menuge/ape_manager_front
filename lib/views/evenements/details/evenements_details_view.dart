import 'package:ape_manager_front/models/Evenement.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details_view_desktop.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details_view_mobile.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:flutter/material.dart';

class EvenementsDetailsView extends StatelessWidget {
  static String routeName = '/evenements/details';

  final Evenement evenement = Evenement(
      titre: "Opération chocolat",
      description:
          "Vente de boîte de chocolat noir, au lait et blanc. Pralinés ou fourrés, avec cette opération vous trouverez le chocolat de vos rêves !",
      statut: "En cours");

  EvenementsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: const EvenementsDetailsViewMobile(
        profil: Profil.Parent,
      ),
      desktopBody: EvenementsDetailsViewDesktop(
        evenement: evenement,
        profil: Profil.Parent,
      ),
    );
  }
}
