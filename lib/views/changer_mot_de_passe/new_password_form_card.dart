import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/views/changer_mot_de_passe/former_password_field.dart';
import 'package:flutter/material.dart';

import 'confirm_new_password.dart';
import 'email_form_field.dart';
import 'new_password_form_field.dart';
import 'submit_button.dart';

class NewPasswordFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const NewPasswordFormCard({Key? key, required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = 600;
          double width =
              constraints.maxWidth > maxWidth ? maxWidth : constraints.maxWidth;
          return Container(
            width: width,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => print('retour')),
                    ],
                  ),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      'École et Collège\nSte Marie Perenchies',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const EmailFormField(),
                  const SizedBox(height: 20),
                  const FormerPasswordFormField(),
                  const SizedBox(height: 20),
                  const NewPasswordFormField(),
                  const SizedBox(height: 20),
                  const ConfirmPasswordFormField(),
                  const SizedBox(height: 20),
                  SubmitButton(
                    formKey: formKey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
