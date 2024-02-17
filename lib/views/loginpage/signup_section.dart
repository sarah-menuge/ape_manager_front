import 'package:flutter/material.dart';

import 'signup_button.dart';
import 'signup_prompt.dart';

class SignUpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
         Column(
          children: [
            SignUpPrompt(),
            SizedBox(height: 20),
          ],
        ),
        SignUpButton(),
      ],
    );
  }
}