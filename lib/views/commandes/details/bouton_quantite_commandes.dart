import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class QuantiteBoutonCommande extends StatelessWidget {
  final LigneCommande ligneCommande;

  const QuantiteBoutonCommande({
    super.key,
    required this.ligneCommande,
  });

  int get quantite => ligneCommande.quantite;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 50,
        width: ResponsiveConstraint.getResponsiveValue(context, 115.0, 100.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Icon(Icons.remove, color: Colors.transparent),
            ),
            Expanded(
              child: Text(
                "x ${quantite.toString()}",
                textAlign: TextAlign.center,
                style: FontUtils.getFontApp(
                  fontWeight: FontWeight.normal,
                  fontSize: ResponsiveConstraint.getResponsiveValue(
                      context, POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
                  color: NOIR,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Icon(Icons.add, color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
