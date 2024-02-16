import 'package:ape_manager_front/views/evenements/evenements.dart';
import 'package:ape_manager_front/widgets/NotFound.dart';
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
        } else if (settings.name == Evenements.routeName) {
          return MaterialPageRoute(builder: (_) => Evenements());
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
