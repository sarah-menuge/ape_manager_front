import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import 'signup_button.dart';

class SignupSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Pas de compte ?',
          style: TextStyle(color: NOIR, fontSize: 17),
        ),
        const SizedBox(height: 20),
        SignUpButton(),
      ],
    );
  }
}
