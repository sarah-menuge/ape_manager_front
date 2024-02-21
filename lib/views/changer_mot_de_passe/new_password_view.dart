import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

import 'new_password_form_card.dart';

class NewPasswordView extends StatefulWidget {
  static String routeName = '/new_pass';

  @override
  _NewPasswordViewState createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: NewPasswordFormCard(formKey: _formKey),
        ),
      ),
    );
  }
}
