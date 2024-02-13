import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LogPage());
}

class LogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accueil',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AccueilView(),
    );
  }
}
