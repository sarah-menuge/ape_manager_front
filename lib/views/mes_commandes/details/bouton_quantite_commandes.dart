import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class QuantiteBoutonCommande extends StatelessWidget {
  final bool disabled;
  final Function ajouterArticle;
  final Function retirerArticle;
  final Function augmenterQuantite;
  final Function diminuerQuantite;
  final LigneCommande ligneCommande;

  const QuantiteBoutonCommande({
    super.key,
    required this.ajouterArticle,
    required this.retirerArticle,
    required this.augmenterQuantite,
    required this.diminuerQuantite,
    required this.ligneCommande,
    this.disabled = false,
  });

  int get quantite => ligneCommande.quantite;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: disabled
            ? Colors.transparent
            : quantite == 0
                ? BLEU
                : VERT_FONCE,
        elevation: 0,
        child: SizedBox(
          height: 50,
          width: ResponsiveConstraint.getResponsiveValue(context, 115.0, 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (quantite > 0 && !disabled)
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    diminuerQuantite(ligneCommande);
                    retirerArticle(ligneCommande.article);
                  },
                ),
              if (quantite <= 0 || disabled)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Icon(
                    Icons.remove,
                    color: Colors.transparent,
                  ),
                ),
              Expanded(
                child: Text(
                  disabled ? "x ${quantite.toString()}" : quantite.toString(),
                  textAlign: TextAlign.center,
                  style: FontUtils.getFontApp(
                      fontWeight:
                          disabled ? FontWeight.normal : FontWeight.w300,
                      fontSize: ResponsiveConstraint.getResponsiveValue(context,
                          POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
                      color: disabled ? NOIR : BLANC),
                ),
              ),
              if (!disabled)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    augmenterQuantite(ligneCommande);
                    ajouterArticle(ligneCommande.article);
                  },
                ),
              if (disabled)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Icon(
                    Icons.add,
                    color: Colors.transparent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
