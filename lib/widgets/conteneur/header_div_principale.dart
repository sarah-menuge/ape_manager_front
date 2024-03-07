import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/logo.dart';
import 'package:flutter/material.dart';

class HeaderDivPrincipale extends StatelessWidget {
  final bool ajouterBoutonRetour;
  final String? titre;

  const HeaderDivPrincipale({
    super.key,
    this.ajouterBoutonRetour = false,
    this.titre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BEIGE_CLAIR,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Row(
          mainAxisAlignment: ajouterBoutonRetour
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (ajouterBoutonRetour) BoutonRetour(),
            if (titre != null)
              Flexible(
                child: Text(
                  titre!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: ResponsiveConstraint.getResponsiveValue(
                        context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2),
                  ),
                ),
              ),
            if (titre == null)
              LogoPopup(
                tailleMinAffichageTexte: ajouterBoutonRetour ? 350 : 250,
                reduirePourMobile: true,
              ),
            if (ajouterBoutonRetour)
              BoutonRetour(invisibleEtNonCliquable: true),
          ],
        ),
      ),
    );
  }
}
