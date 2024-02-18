import 'package:ape_manager_front/views/signup/signup_form_card.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

class SignupView extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: SignUpFormCard(formKey: _formKey),
        ),
      ),
    );
  }
}
