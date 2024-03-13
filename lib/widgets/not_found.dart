import 'package:ape_manager_front/widgets/conteneur/div_principale.dart';
import 'package:ape_manager_front/widgets/conteneur/header_div_principale.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: DivPrincipale(
          header: const HeaderDivPrincipale(titre: "Page introuvable"),
          nomUrlRetour: '',
          body: getContenuPage404(context),
        ),
      ),
    );
  }

  Widget getContenuPage404(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "La page que vous tentez d'accéder n'existe pas. Dommage.",
            textAlign: TextAlign.center,
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: const Image(
              image: AssetImage("assets/images/page_introuvable.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
