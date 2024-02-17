import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import 'login_card.dart';

class LoginScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: LoginCard(),
          ),
        ),
      ),
    );
  }
}