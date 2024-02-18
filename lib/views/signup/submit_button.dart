import 'package:flutter/material.dart';
import '../../proprietes/couleurs.dart'; // Assurez-vous que le chemin est correct

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SubmitButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Formulaire soumis avec succès !')),
          );
        }
      },
      child: Text('Valider'),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
    );
  }
}
