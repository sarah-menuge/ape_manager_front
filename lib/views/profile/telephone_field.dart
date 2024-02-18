import 'package:flutter/material.dart';

class TelephoneField extends StatelessWidget {
  const TelephoneField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
          children: [
            const Text(
              'Nom',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.phone,
              initialValue: "0785497852",
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              style: const TextStyle(height: 1),
            ),
          ],
        ));
  }
}
