import 'package:ape_manager_front/views/login/signup_section.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import '../../responsive/responsive_layout.dart';
import 'login_card.dart';
import 'login_section.dart';

class LoginView extends StatelessWidget {
  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        // Div principale
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: BEIGE_CLAIR,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ResponsiveLayout(
              mobileBody: LoginSection(),
              desktopBody: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveConstraint.getResponsiveValue(
                      context, 20.0, 0.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
