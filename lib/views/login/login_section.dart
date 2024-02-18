// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/login/signup_button.dart';
import 'package:flutter/material.dart';

import 'email_form_field.dart';
import 'forgot_password_button.dart';
import 'login_button.dart';
import 'password_form_field.dart';

class LoginSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo + nom de l'école
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset('assets/images/logoEcole.png',
                        width: 80, height: 80),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Association des parents d\'élèves \n',
                            style: FontUtils.getFontApp(
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: 'École et Collège\nSte Marie Perenchies',
                            style: FontUtils.getFontApp(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60, width: 10),

            // Formulaire de connexion
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    EmailFormField(),
                    const SizedBox(height: 20),
                    PasswordFormField(),
                    ForgotPasswordButton(),
                    // Boutons se connecter / s'inscrire
                    const SizedBox(height: 50),
                    ResponsiveLayout(
                      mobileBody: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LoginButton(),
                          SignUpButton(),
                        ],
                      ),
                      desktopBody: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LoginButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
