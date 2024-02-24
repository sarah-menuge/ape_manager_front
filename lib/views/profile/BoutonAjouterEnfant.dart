import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class BoutonAjouterEnfant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Ajouter Enfant'),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
    );
  }
}