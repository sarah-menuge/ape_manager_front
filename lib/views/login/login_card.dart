import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';

import 'login_section.dart';
import 'signup_section.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: LoginSection(),
      desktopBody: Container(
        padding: EdgeInsets.symmetric(
          horizontal:
              ResponsiveConstraint.getResponsiveValue(context, 20.0, 0.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: LoginSection(),
              ),
            ),
            Container(
              color: Colors.grey,
              child: const SizedBox(height: 200, width: 2),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: SignupSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
