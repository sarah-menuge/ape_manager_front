import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class BoutonChangerMDP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text('Modifier mon mot de passe'),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: ROUGE,
      ),
    );
  }
}
