import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        } else if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
