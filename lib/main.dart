import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/changer_mot_de_passe/forgot_password_view.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/login/login_view.dart';
import 'package:ape_manager_front/views/mes_commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/views/profil/profil_view.dart';
import 'package:ape_manager_front/views/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setPathUrlStrategy();
  runApp(MainApp());
}

final _router = GoRouter(
  initialLocation: AccueilView.routeURL,
  routes: [
    GoRoute(
      path: LoginView.routeURL,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: SignupView.routeURL,
      builder: (context, state) => SignupView(),
    ),
    GoRoute(
      path: AccueilView.routeURL,
      builder: (context, state) => const AccueilView(),
    ),
    GoRoute(
      path: EvenementsView.routeURL,
      builder: (context, state) => const EvenementsView(),
    ),
    GoRoute(
      path: DetailEvenementView.routeURL,
      builder: (context, state) {
        int id = int.tryParse(state.pathParameters['idEvent'] ?? '')!;
        return DetailEvenementView(eventId: id);
      },
    ),
    GoRoute(
      path: ProfilView.routeURL,
      builder: (context, state) => const ProfilView(),
    ),
    GoRoute(
      path: ForgotPasswordView.routeURL,
      builder: (context, state) => const ForgotPasswordView(),
    ),
    GoRoute(
      path: MesCommandesView.routeURL,
      builder: (context, state) => const MesCommandesView(),
    ),
  ],
  // Permet d'imposer l'authentification
  redirect: (BuildContext context, GoRouterState state) {
    afficherLogDebug(
      "Tentative d'accès à la page '${state.location.toString()}'.",
    );
    if (state.location == SignupView.routeURL ||
        state.location == LoginView.routeURL) {
      afficherLogDebug("Accès autorisé.");
      return null;
    }
    if (!Provider.of<AuthentificationProvider>(context, listen: false)
        .isLoggedIn) {
      afficherLogWarning(
        "Utilisateur non authentifié : redirection vers le login.",
      );
      return LoginView.routeURL;
    } else {
      afficherLogDebug("Accès autorisé.");
      return null;
    }
  },
);

class MainApp extends StatelessWidget {
  final AuthentificationProvider authentificationProvider =
      AuthentificationProvider();
  final EvenementProvider evenementProvider = EvenementProvider();
  final UtilisateurProvider utilisateurProvider = UtilisateurProvider();

  MainApp({super.key});

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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
