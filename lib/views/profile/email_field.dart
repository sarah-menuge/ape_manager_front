import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EmailField extends StatelessWidget {
  final bool readOnly;

  const EmailField({Key? key, this.readOnly = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: readOnly,
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
