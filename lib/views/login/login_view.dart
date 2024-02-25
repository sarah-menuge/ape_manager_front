import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import 'login_card.dart';

class LoginView extends StatelessWidget {
  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1000,
            maxHeight: 600,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: BEIGE_CLAIR,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LoginCard(),
        ),
      ),
    );
  }
}
