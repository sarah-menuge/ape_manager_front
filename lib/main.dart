import 'package:flutter/material.dart';

import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/evenements/evenements_view.dart';
import 'package:ape_manager_front/views/signup_page/signup_screen.dart';
import 'package:ape_manager_front/views/loginpage/login_screen.dart';
import 'package:ape_manager_front/widgets/not_found.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreenView.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == LoginScreenView.routeName) {
          return MaterialPageRoute(builder: (_) => LoginScreenView());
        } else if (settings.name == AccueilView.routeName) {
          return MaterialPageRoute(builder: (_) => AccueilView());
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
