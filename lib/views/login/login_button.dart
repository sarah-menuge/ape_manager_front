import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AccueilView.routeName,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: BLANC,
        backgroundColor: BLEU,
      ),
      child: const Text('Se connecter'),
    );
  }
}
