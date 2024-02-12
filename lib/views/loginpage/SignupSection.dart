import 'package:flutter/material.dart';

import 'SignupButton.dart';
import 'SignupPrompt.dart';

class SignUpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50),
        SignUpPrompt(),
        SignUpButton(),
      ],
    );
  }
}