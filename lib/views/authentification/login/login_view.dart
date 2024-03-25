import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/authentification/login/login_form_view.dart';
import 'package:ape_manager_front/views/authentification/signup/signup_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/div_principale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../providers/authentification_provider.dart';
import '../../../providers/utilisateur_provider.dart';
import '../../../utils/afficher_message.dart';
import '../../accueil/accueil_view.dart';
import 'StockageIdentifiants.dart';
import 'biometrique.dart';

class LoginView extends StatelessWidget {
  static String routeURL = '/login';
  static String routeURLValidationCompte = '/login?success=true';
  final Biometrique _biometrique = Biometrique();
  final StockageIdentifiants _stockageIdentifiants = StockageIdentifiants();
  final bool compteValide;

  LoginView({
    super.key,
    this.compteValide = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compteValide == true) {
      afficherMessageInfo(
          context: context,
          message:
              "Votre compte a bien été activé. Vous pouvez dès à présent vous connecter.");
    }

    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: DefaultTextStyle(
        style: const TextStyle(fontFamilyFallback: ['Roboto'], color: NOIR),
        child: DivPrincipale(
          maxWidth: 800,
          body: getContenuLoginResponsive(context),
          nomUrlRetour: '',
        ),
      ),
    );
  }

  Widget getContenuLoginResponsive(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: getSectionLogin(),
      desktopBody: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(flex: 1, child: getSectionLogin()),
          const SizedBox(
            height: 200,
            child: VerticalDivider(
              color: GRIS_FONCE,
              width: 1,
            ),
          ),
          Expanded(child: getSectionSignup(context)),
        ],
      ),
    );
  }

  Widget getSectionLogin() {
    return const SingleChildScrollView(
      child: LoginFormView(),
    );
  }

  Widget getSectionSignup(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Pas de compte ?',
            style: TextStyle(color: NOIR, fontSize: 17),
          ),
        ),
        getBoutonSignup(context),
      ],
    );
  }

  Widget getBoutonSignup(BuildContext context) {
    return BoutonNavigationGoRouter(
      text: "S'inscrire",
      themeCouleur: ThemeCouleur.rouge,
      routeName: SignupView.routeURL,
    );
  }
}
