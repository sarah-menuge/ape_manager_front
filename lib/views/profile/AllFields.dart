import 'package:flutter/material.dart';

import 'prenom_field.dart';
import 'telephone_field.dart';
import 'email_field.dart';
import 'nom_field.dart';

class AllFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: 350,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NomField(),
            SizedBox(
              height: 10,
            ),
            PrenomField(),
            SizedBox(
              height: 10,
            ),
            EmailField(),
            SizedBox(
              height: 10,
            ),
            TelephoneField(),
          ],
        ),
      ),
    );
  }
}