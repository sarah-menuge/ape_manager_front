import 'package:flutter/material.dart';

import 'views/loginpage/LoginScreen.dart';

void main() {
  runApp(LogPage());
}

class LogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Écran de connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
