import 'package:ape_manager_front/views/signup/signup_card.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

class SignupView extends StatelessWidget {
  static String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: SignUpCard(),
        ),
      ),
    );
  }
}