import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
        ),
        style: const TextStyle(height: 1),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email address';
          } else if (!value.contains('@')) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }
}
