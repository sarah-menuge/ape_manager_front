import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/loginpage/signup_button.dart';
import 'package:flutter/material.dart';

import 'email_form_field.dart';
import 'forgot_password_button.dart';
import 'login_button.dart';
import 'logo_header.dart';
import 'password_form_field.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child : Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

        LogoHeader(),
          SizedBox(width: 10),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Association des parents d\'élèves \n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'École et Collège\nSte Marie Perenchies', style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          )
          ,
        ],
    ),
        SizedBox(height: 10),
        EmailFormField(),
        SizedBox(height: 20),
        PasswordFormField(),
        ForgotPasswordButton(),
        ResponsiveLayout(mobileBody: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginButton(),
            SizedBox(width: 10),
            SignUpButton(),
          ],
        ) , desktopBody: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginButton(),
          ],
        ) )


      ],
    ));
  }
}