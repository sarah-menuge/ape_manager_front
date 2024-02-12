import 'package:flutter/material.dart';

import 'EmailFormField.dart';
import 'ForgotPasswordButton.dart';
import 'LoginButton.dart';
import 'LogoHeader.dart';
import 'PasswordFormField.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(50.0),
    child : Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LogoHeader(),
        SizedBox(height: 50),
        EmailFormField(),
        SizedBox(height: 20),
        PasswordFormField(),
        SizedBox(height: 20),
        ForgotPasswordButton(),
        SizedBox(height: 20),
        LoginButton(),
      ],
    ));
  }
}