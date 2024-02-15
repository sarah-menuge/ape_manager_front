import 'package:ape_manager_front/widgets/NotFound.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return const NotFound();
        });
      },
    );
  }
}
