import 'package:ape_manager_front/views/loginpage/logo_header.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';

import 'password_form_field.dart';
import 'prenom_form_field.dart';
import 'submit_button.dart';
import 'telephone_form_field.dart';
import 'email_form_field.dart';
import 'nom_form_field.dart';

class SignUpFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SignUpFormCard({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: ResponsiveConstraint.getResponsiveValue(context, double.infinity, 1000)),
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: BEIGE_CLAIR,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LogoHeader(),
              SizedBox(height: 10),
              NomFormField(),
              SizedBox(height: 10),
              PrenomFormField(),
              SizedBox(height: 10),
              EmailFormField(),
              SizedBox(height: 10),
              TelephoneFormField(),
              SizedBox(height: 20),
              PasswordFormField(),
              SizedBox(height: 20),
              SubmitButton(formKey: formKey,),
            ],
          ),
        ),
      );
  }
}
