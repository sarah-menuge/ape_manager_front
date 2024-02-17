import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';

import 'login_form.dart';
import 'signup_section.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth:ResponsiveConstraint.getResponsiveValue(context, double.infinity, 1000)),
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: BEIGE_CLAIR,
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
        child: ResponsiveLayout(
          mobileBody:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LoginForm(),
          ],
        ) ,
          desktopBody : Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: LoginForm(),
              ),
              VerticalDivider(
                color: GRIS,
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