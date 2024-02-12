import 'package:flutter/material.dart';

import 'LoginForm.dart';
import 'SignupSection.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isScreenNarrow = MediaQuery.of(context).size.width < 600;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: isScreenNarrow ? double.infinity : 1000),
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFF6ED),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: isScreenNarrow ? Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LoginForm(),
            SizedBox(height: 20), // Espacement entre les formulaires de connexion et d'inscription
            SignUpSection(),
          ],
        ) : IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: LoginForm(),
              ),
              VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
              Expanded(
                flex: 1,
                child: SignUpSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}