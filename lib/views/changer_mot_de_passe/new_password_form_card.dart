import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/views/changer_mot_de_passe/former_password_field.dart';
import 'package:flutter/material.dart';

import 'confirm_new_password.dart';
import 'email_form_field.dart';
import 'new_password_form_field.dart';

class NewPasswordFormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = 600;
        return SingleChildScrollView(
          child: Container(
            width: constraints.maxWidth > maxWidth ? maxWidth : constraints.maxWidth,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text('Retour'),
                  ],
                ),
                Image.asset('assets/images/logoEcole.png', width: 80, height: 80),
                const SizedBox(height: 12),
                const Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Association des parents d\'élèves \n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'École et Collège\nSte Marie Perenchies',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const EmailFormField(),
                const SizedBox(height: 10),
                const FormerPasswordFormField(),
                const SizedBox(height: 10),
                const NewPasswordFormField(),
                const SizedBox(height: 10),
                const ConfirmPasswordFormField(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => print('submit'),
                  child: const Text('Valider'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BLEU,
                    foregroundColor: BLANC,
                    minimumSize: const Size(200, 50),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
