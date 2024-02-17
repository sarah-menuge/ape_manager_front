import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: Text('S\'inscrire'),
      style: ElevatedButton.styleFrom(
        backgroundColor: ROUGE,
        foregroundColor: BLANC,
      ),
    );
  }
}