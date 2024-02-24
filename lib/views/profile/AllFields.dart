import 'package:flutter/material.dart';

import 'prenom_field.dart';
import 'telephone_field.dart';
import 'email_field.dart';
import 'nom_field.dart';

class AllFields extends StatelessWidget {
  final bool readOnly;

  const AllFields({this.readOnly = true});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: 350,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NomField(readOnly: readOnly),
            SizedBox(
              height: 30,
            ),
            PrenomField(readOnly: readOnly),
            SizedBox(
              height: 30,
            ),
            EmailField(readOnly: readOnly),
            SizedBox(
              height: 30,
            ),
            TelephoneField(readOnly: readOnly),
          ],
        ),
      ),
    );
  }
}