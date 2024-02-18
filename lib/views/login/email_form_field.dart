import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(height: 1),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
