import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: BLANC,
        backgroundColor: BLEU,
      ),
      child: const Text('Se connecter'),
    );
  }
}
