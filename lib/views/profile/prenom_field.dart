import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrenomField extends StatelessWidget {
  const PrenomField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
          children: [
            const Text(
              'Prénom',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              readOnly: true,
              initialValue: "Fifou",
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              style: const TextStyle(height: 1),
            ),
          ],
        ));
  }
}
