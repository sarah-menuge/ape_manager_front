import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/changer_mot_de_passe/forgot_password_view.dart';
import 'package:ape_manager_front/views/changer_mot_de_passe/new_password_view.dart';
import 'package:ape_manager_front/views/evenements/evenements_view.dart';
import 'package:ape_manager_front/views/login/login_view.dart';
import 'package:ape_manager_front/views/profile/profile_view.dart';
import 'package:ape_manager_front/views/signup/signup_view.dart';
import 'package:ape_manager_front/widgets/not_found.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final AuthentificationProvider authentificationProvider =
      AuthentificationProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authentificationProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginView.routeName,
        onGenerateRoute: (settings) {
          if (settings.name == LoginView.routeName) {
            return MaterialPageRoute(builder: (_) => LoginView());
          } else if (settings.name == SignupView.routeName) {
            return MaterialPageRoute(builder: (_) => SignupView());
          } else if (settings.name == AccueilView.routeName) {
            return MaterialPageRoute(builder: (_) => AccueilView());
          } else if (settings.name == EvenementsView.routeName) {
            return MaterialPageRoute(builder: (_) => EvenementsView());
          } else if (settings.name == ProfileView.routeName) {
            return MaterialPageRoute(builder: (_) => ProfileView());
          } else if (settings.name == ForgotPasswordView.routeName) {
          return MaterialPageRoute(builder: (_) => ForgotPasswordView());
          } else if (settings.name == NewPasswordView.routeName) {
            return MaterialPageRoute(builder: (_) => NewPasswordView());
          } else if (settings.name == ProfileView.routeName) {
          return MaterialPageRoute(builder: (_) => ProfileView());
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return const NotFound();
          });
        },
      ),
    );
  }
}
