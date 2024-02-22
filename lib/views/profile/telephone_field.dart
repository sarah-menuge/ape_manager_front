import 'package:flutter/material.dart';

class TelephoneField extends StatelessWidget {
  const TelephoneField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.phone,
              initialValue: "0785497852",
              decoration: const InputDecoration(
                labelText: "Téléphone",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              style: const TextStyle(height: 1),
            ),
          );
  }
}
