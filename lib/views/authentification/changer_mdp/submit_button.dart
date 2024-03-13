import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';

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
            const SnackBar(content: Text('Formulaire soumis avec succès !')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
      child: const Text('Valider'),
    );
  }
}
