import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class LogoPopup extends StatelessWidget {
  final int tailleMinAffichageTexte;
  final bool reduirePourMobile;

  LogoPopup({
    super.key,
    this.tailleMinAffichageTexte = 460,
    this.reduirePourMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(child: getLogo(context)),
        if (estDesktop(context, tailleMinAffichageTexte)) getTextes(context),
      ],
    );
  }

  Widget getLogo(BuildContext context) {
    double taille =
        ResponsiveConstraint.getResponsiveValue(context, 70.0, 85.0);
    final Image logoEcole = Image.asset(
      'assets/images/logoEcole.png',
      width: taille,
      height: taille,
    );

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: logoEcole,
    );
  }

  Widget getTextes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            ResponsiveConstraint.getResponsiveValue(
                context,
                "Association des parents\nd'élèves",
                "Association des parents d'élèves"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:
                  ResponsiveConstraint.getResponsiveValue(context, 12.0, null),
            ),
          ),
        ),
        Text(
          "École et Collège",
          style: TextStyle(
            fontSize:
                ResponsiveConstraint.getResponsiveValue(context, 11.0, null),
          ),
        ),
        Text(
          "Ste Marie Perenchies",
          style: TextStyle(
            fontSize:
                ResponsiveConstraint.getResponsiveValue(context, 11.0, null),
          ),
        ),
      ],
    );
  }
}
