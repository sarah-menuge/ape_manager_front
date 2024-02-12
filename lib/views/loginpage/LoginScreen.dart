import 'package:flutter/material.dart';

import 'LoginCard.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEED9C4),
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