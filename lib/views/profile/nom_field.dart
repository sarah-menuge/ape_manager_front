import 'package:flutter/material.dart';

class NomField extends StatelessWidget {
  final bool readOnly;

  const NomField({Key? key, this.readOnly = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: readOnly,
              initialValue: "pipou",
              decoration: const InputDecoration(
                labelText: "Nom",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              style: const TextStyle(height: 1),
            ),
          );
  }
}
