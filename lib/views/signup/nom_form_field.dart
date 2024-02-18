import 'package:flutter/material.dart';

class NomFormField extends StatelessWidget {
  const NomFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nom',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
        style: const TextStyle(height: 1),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your last name';
          }
          return null;
        },
      ),
    );
  }
}
