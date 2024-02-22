import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.emailAddress,
              initialValue: 'pipouFifou@popojocomomopipipopoupopopomamemimomumuma.com',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                labelText: 'Email'
              ),
              style: const TextStyle(height: 1),
            ),
          );
  }
}
