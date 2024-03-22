import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/conteneur/div_principale.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';

class PageNonAccessible extends StatelessWidget {
  final String nomUrlRetour;

  const PageNonAccessible({
    super.key,
    required this.nomUrlRetour,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: DivPrincipale(
        body: Container(
          height: 200,
          constraints: const BoxConstraints(maxHeight: 200),
          child: Center(
            child: Text(
              "Vous n'avez pas le droit d'accéder à la page.",
              textAlign: TextAlign.center,
              style: FontUtils.getFontApp(
                fontSize: 20,
              ),
            ),
          ),
        ),
        nomUrlRetour: nomUrlRetour,
        minHeight: 400,
      ),
    );
  }
}
