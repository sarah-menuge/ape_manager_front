import 'package:flutter/material.dart';

import 'signup_button.dart';
import 'signup_prompt.dart';

class SignupSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignUpPrompt(),
        const SizedBox(height: 20),
        SignUpButton(),
      ],
    );
  }
}
