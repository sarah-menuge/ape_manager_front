import 'package:flutter/material.dart';

class TelephoneFormField extends StatelessWidget {
  const TelephoneFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Téléphone',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone),
        ),
        style: const TextStyle(height: 1),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          }
          return null;
        },
      ),
    );
  }
}
