import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/changer_mot_de_passe/forgot_password_view.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/login/login_view.dart';
import 'package:ape_manager_front/views/mes_commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/views/profil/profil_view.dart';
import 'package:ape_manager_front/views/signup/signup_view.dart';
import 'package:ape_manager_front/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'models/evenement.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final AuthentificationProvider authentificationProvider =
      AuthentificationProvider();
  final EvenementProvider evenementProvider = EvenementProvider();
  final UtilisateurProvider utilisateurProvider = UtilisateurProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authentificationProvider),
        ChangeNotifierProvider.value(value: utilisateurProvider),
        ChangeNotifierProvider.value(value: evenementProvider),
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
          } else if (settings.name == DetailEvenementView.routeName) {
            final evenement = settings.arguments as Evenement;
            return MaterialPageRoute(
                builder: (_) => DetailEvenementView(
                      evenement: evenement,
                    ));
          } else if (settings.name == ProfilView.routeName) {
            return MaterialPageRoute(builder: (_) => ProfilView());
          } else if (settings.name == ForgotPasswordView.routeName) {
            return MaterialPageRoute(builder: (_) => ForgotPasswordView());
          } else if (settings.name == MesCommandesView.routeName) {
            return MaterialPageRoute(builder: (_) => MesCommandesView());
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) => NotFound());
        },
      ),
    );
  }
}
