import 'package:flutter/material.dart';

class NewPasswordFormField extends StatelessWidget {
  const NewPasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Nouveau Mot de passe',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
        ),
        style: const TextStyle(height: 1),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }
}
