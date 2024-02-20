import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class LoginButton extends StatelessWidget {
  final Function envoiFormulaireLogin;

  const LoginButton({required this.envoiFormulaireLogin});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        envoiFormulaireLogin();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: BLANC,
        backgroundColor: BLEU,
      ),
      child: const Text('Se connecter'),
    );
  }
}
