import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class BoutonModifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Modifier'),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
    );
  }
}
