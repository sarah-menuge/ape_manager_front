import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return(TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
    ));
  }
}