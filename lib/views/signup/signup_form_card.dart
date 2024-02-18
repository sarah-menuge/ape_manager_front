import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

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
        padding: const EdgeInsets.all(20.0),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset('assets/images/logoEcole.png',
                      width: 80, height: 80),
                ),
                const SizedBox(width: 12),
                const Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Association des parents d\'élèves \n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'École et Collège\nSte Marie Perenchies',
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const NomFormField(),
            const SizedBox(height: 20),
            const PrenomFormField(),
            const SizedBox(height: 20),
            const EmailFormField(),
            const SizedBox(height: 20),
            const TelephoneFormField(),
            const SizedBox(height: 20),
            const PasswordFormField(),
            const SizedBox(height: 20),
            SubmitButton(
              formKey: formKey,
            ),
          ],
        ),
      ),
    );
  }
}
