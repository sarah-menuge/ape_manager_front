import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/admin/gestion_utilisateurs/gestion_utilisateurs_view.dart';
import 'package:ape_manager_front/views/authentification/changer_mdp/modification_mdp_view.dart';
import 'package:ape_manager_front/views/authentification/login/login_view.dart';
import 'package:ape_manager_front/views/authentification/signup/signup_view.dart';
import 'package:ape_manager_front/views/commandes/details/detail_commande_view.dart';
import 'package:ape_manager_front/views/commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/views/evenements/creation/creer_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/modification/modifier_evenement_view.dart';
import 'package:ape_manager_front/views/profil/profil_view.dart';
import 'package:ape_manager_front/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setHashUrlStrategy();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final AuthentificationProvider authentificationProvider =
      AuthentificationProvider();
  final EvenementProvider evenementProvider = EvenementProvider();
  final UtilisateurProvider utilisateurProvider = UtilisateurProvider();
  final CommandeProvider commandeProvider = CommandeProvider();

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
        ChangeNotifierProvider.value(value: commandeProvider),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: AccueilView.routeURL,
  errorBuilder: (context, state) => const NotFound(),
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
      path: ModificationMdpView.routeURL,
      builder: (context, state) {
        String token = state.pathParameters['token']!;
        return ModificationMdpView(token: token);
      },
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
      path: CreerEvenementView.routeURL,
      builder: (context, state) => const CreerEvenementView(),
    ),
    GoRoute(
      path: ProfilView.routeURL,
      builder: (context, state) => const ProfilView(),
    ),
    GoRoute(
      path: MesCommandesView.routeURL,
      builder: (context, state) => const MesCommandesView(),
    ),
    GoRoute(
      path: CommandeView.routeURL,
      builder: (context, state) {
        int id = int.tryParse(state.pathParameters['idCommande'] ?? '')!;
        return CommandeView(idCommande: id);
      },
    ),
    GoRoute(
      path: ModifierEvenementView.routeURL,
      builder: (context, state) {
        int id = int.tryParse(state.pathParameters['idEvent'] ?? '')!;
        return ModifierEvenementView(evenementId: id);
      },
    ),
    GoRoute(
      path: GestionUtilisateursView.routeURL,
      builder: (context, state) => const GestionUtilisateursView(),
    ),
  ],
  // Permet d'imposer l'authentification
  redirect: (BuildContext context, GoRouterState state) {
    afficherLogDebug(
      "Tentative d'accès à la page '${state.location.toString()}'.",
    );

    if (state.location == SignupView.routeURL ||
        state.location == LoginView.routeURL ||
        state.location
            .contains(ModificationMdpView.routeURL.replaceAll(":token", ""))) {
      afficherLogDebug("Accès autorisé.");
      return null;
    }
    if (state.location == "/logout") {
      afficherLogInfo("Déconnexion en cours");
      Provider.of<UtilisateurProvider>(context, listen: false).updateUser(null);
      Provider.of<AuthentificationProvider>(context, listen: false).isLoggedIn =
          false;
      naviguerVersPage(context, LoginView.routeURL);
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
