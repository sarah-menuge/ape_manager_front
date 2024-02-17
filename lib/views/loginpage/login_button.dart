import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      },
      child: Text('Se connecter'),
      style: ElevatedButton.styleFrom(
        foregroundColor: BLANC,
        backgroundColor: BLEU,
      ),
    );
  }
}