import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Mot de passe',
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(height: 1),
        obscureText: true,
      ),
    );
  }
}
