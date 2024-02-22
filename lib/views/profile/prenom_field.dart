import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrenomField extends StatelessWidget {
  const PrenomField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: true,
              initialValue: "Fifou",
              decoration: const InputDecoration(
                labelText: "Prénom",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              style: const TextStyle(height: 1),
            ),
          );
  }
}
