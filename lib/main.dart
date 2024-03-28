import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/utils/stockage_hardware.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/admin/gestion_utilisateurs/gestion_utilisateurs_view.dart';
import 'package:ape_manager_front/views/authentification/changer_mdp/modification_mdp_view.dart';
import 'package:ape_manager_front/views/authentification/login/login_view.dart';
import 'package:ape_manager_front/views/authentification/signup/signup_view.dart';
import 'package:ape_manager_front/views/commandes/details/detail_commande_view.dart';
import 'package:ape_manager_front/views/commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/views/commandes/retrait/retrait_commandes_view.dart';
import 'package:ape_manager_front/views/evenements/creation/creer_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/evenements/modification/modifier_evenement_view.dart';
import 'package:ape_manager_front/views/profil/profil_view.dart';
import 'package:ape_manager_front/widgets/not_found.dart';
import 'package:ape_manager_front/widgets/scaffold/aucune_transition.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

final AuthentificationProvider authentificationProvider =
    AuthentificationProvider();
final EvenementProvider evenementProvider = EvenementProvider();
final UtilisateurProvider utilisateurProvider = UtilisateurProvider();
final CommandeProvider commandeProvider = CommandeProvider();

void main() async {
  setHashUrlStrategy();
  // setPathUrlStrategy();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    bool isReleaseMode = kReleaseMode;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authentificationProvider),
        ChangeNotifierProvider.value(value: utilisateurProvider),
        ChangeNotifierProvider.value(value: evenementProvider),
        ChangeNotifierProvider.value(value: commandeProvider),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: PROD == "false" || !isReleaseMode,
        routerConfig: _router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
        theme: appTheme(),
      ),
    );
  }

  ThemeData appTheme() {
    final builder = AucuneTransition();
    return ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: builder,
      TargetPlatform.fuchsia: builder,
      TargetPlatform.iOS: builder,
      TargetPlatform.linux: builder,
      TargetPlatform.macOS: builder,
      TargetPlatform.windows: builder,
    }));
  }
}

final _router = GoRouter(
  initialLocation: AccueilView.routeURL,
  errorBuilder: (context, state) => const NotFound(),
  routes: [
    GoRoute(
      path: LoginView.routeURL,
      builder: (context, state) {
        bool compteValide = state.queryParameters['success'] == 'true';
        String? lienRedirection = state.queryParameters['next'];
        return LoginView(
          compteValide: compteValide,
          lienRedirection: lienRedirection,
        );
      },
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
    GoRoute(
      path: RetraitCommandeView.routeURL,
      builder: (context, state) => const RetraitCommandeView(),
    ),
  ],
  // Permet d'imposer l'authentification
  redirect: (BuildContext context, GoRouterState state) async {
    afficherLogDebug(
        "Tentative d'accès à la page '${state.location.toString()}'.");

    if (Provider.of<AuthentificationProvider>(context, listen: false)
        .isLoggedIn) {
      afficherLogDebug("Accès autorisé : utilisateur authentifié.");
      if (state.location == LoginView.routeURL) {
        return AccueilView.routeURL;
      }
      return null;
    }

    // Tentative de récupération de la session depuis le token stocké en local
    bool connexionOk = await tentativeConnexionDepuisTokenLocal();
    afficherLogDebug("Tentative de connexion depuis le token local.");
    if (connexionOk) {
      afficherLogDebug("Tentative de connexion depuis le token local : sucès.");
      if (state.location == LoginView.routeURL) {
        return AccueilView.routeURL;
      }
      return null;
    } else {
      afficherLogDebug("Tentative de connexion depuis le token local : échec.");
    }

    if (state.location == SignupView.routeURL ||
        state.location == LoginView.routeURL ||
        state.location.contains(LoginView.routeURLValidationCompte
            .replaceAll("?success=true", "")) ||
        state.location
            .contains(ModificationMdpView.routeURL.replaceAll(":token", ""))) {
      afficherLogDebug(
          "Accès autorisé : Page ne nécessitant pas d'être authentifié.");
      return null;
    }
    if (state.location == "/logout") {
      afficherLogInfo("Déconnexion en cours");
      Provider.of<UtilisateurProvider>(context, listen: false).updateUser(null);
      Provider.of<AuthentificationProvider>(context, listen: false).isLoggedIn =
          false;
      naviguerVersPage(context, LoginView.routeURL);
    }

    afficherLogWarning("Utilisateur non authentifié.");
    afficherLogWarning("Redirection vers le login");
    return "${LoginView.routeURL}?next=${state.location}";
  },
);

Future<bool> tentativeConnexionDepuisTokenLocal() async {
  afficherLogDebug("Tentative connexion depuis le token local");
  String? token = await getValueInHardwareMemory(key: "token");
  afficherLogDebug("token existant : ${token != null}");
  if (token == null) return false;
  final response = await authentificationProvider.recupererConnexionDepuisToken(
      token, utilisateurProvider);
  if (response["statusCode"] == 200) return true;
  return false;
}
