import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrenomFormField extends StatelessWidget {
  const PrenomFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Prénom',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person_outline),
        ),
        style: const TextStyle(height: 1),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your first name';
          }
          return null;
        },
      ),
    );
  }
}
