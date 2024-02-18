import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
          children: [
            const Text(
              'Adresse e-mail',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.emailAddress,
              initialValue: 'pipouFifou@popo.com',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              style: const TextStyle(height: 1),
            ),
          ],
        ));
  }
}
