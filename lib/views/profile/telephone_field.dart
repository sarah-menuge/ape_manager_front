import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TelephoneField extends StatelessWidget {
  final bool readOnly;

  const TelephoneField({Key? key, this.readOnly = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
              readOnly: readOnly,
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
