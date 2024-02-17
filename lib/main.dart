import 'package:ape_manager_front/views/signup_page/signup_screen.dart';
import 'package:flutter/material.dart';

import 'views/loginpage/login_screen.dart';

void main() {
  runApp(LogPage());
}

class LogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Écran de connexion',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreenView(),
      routes: {
        '/signup': (context) => SignUpScreen(), // Définissez la route vers l'écran d'inscription
      },
    );
  }
}
