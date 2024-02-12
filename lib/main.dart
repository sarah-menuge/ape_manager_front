import 'package:flutter/material.dart';

import 'views/loginpage/LoginScreen.dart';

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
      home: LoginScreen(),
    );
  }
}
