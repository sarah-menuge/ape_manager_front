import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class BoutonSupprimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Supprimer'),
      style: ElevatedButton.styleFrom(
        backgroundColor: ROUGE,
        foregroundColor: BLANC,
      ),
    );
  }
}