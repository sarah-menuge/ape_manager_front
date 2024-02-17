import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/evenements/evenements_view.dart';
import 'package:ape_manager_front/widgets/not_found.dart';
import 'package:flutter/material.dart';

import 'views/loginpage/LoginScreen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == LoginScreen.routeName) {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        } else if (settings.name == AccueilView.routeName) {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        } else if (settings.name == EvenementsView.routeName) {
          return MaterialPageRoute(builder: (_) => EvenementsView());
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return const NotFound();
        });
      },
    );
  }
}
