import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    child : TextFormField(
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
    ));
  }
}