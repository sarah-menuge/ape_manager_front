import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrenomField extends StatelessWidget {
  final bool readOnly;

  const PrenomField({Key? key, this.readOnly = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: readOnly,
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
