import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/logo.dart';
import 'package:flutter/material.dart';

class HeaderPopup extends StatelessWidget {
  final bool ajouterBoutonRetour;

  const HeaderPopup({
    super.key,
    this.ajouterBoutonRetour = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BEIGE_CLAIR,
      child: Row(
        mainAxisAlignment: ajouterBoutonRetour
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (ajouterBoutonRetour) BoutonRetour(),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            child: LogoPopup(
              tailleMinAffichageTexte: ajouterBoutonRetour ? 430 : 330,
              reduirePourMobile: true,
            ),
          ),
          if (ajouterBoutonRetour) BoutonRetour(invisibleEtNonCliquable: true),
        ],
      ),
    );
  }
}
