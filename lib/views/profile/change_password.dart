import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import '../changer_mot_de_passe/new_password_form_card.dart';

class BoutonChangerMDP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: NewPasswordFormCard(),
        ),
      ),
      child: Text('Modifier mon mot de passe'),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: ROUGE,
      ),
    );
  }
}
