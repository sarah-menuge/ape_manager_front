import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

import 'forgot_password_form_card.dart';

class ForgotPasswordView extends StatefulWidget {
  static String routeName = '/forgot_pass';

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: ForgotPasswordFormCard(formKey: _formKey),
        ),
      ),
    );
  }
}
