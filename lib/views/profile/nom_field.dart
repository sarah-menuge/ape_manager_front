import 'package:flutter/material.dart';

class NomField extends StatelessWidget {
  const NomField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: true,
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
