import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/login/login_form_view.dart';
import 'package:ape_manager_front/views/signup/signup_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/div_principale.dart';
import 'package:ape_manager_front/widgets/conteneur/header_div_principale.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';

class LoginView extends StatelessWidget {
  static String routeURL = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: DivPrincipale(
        maxWidth: 800,
        body: getContenuLoginResponsive(context),
        nomUrlRetour: '',
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
          Container(
            color: Colors.grey,
            child: const SizedBox(height: 200, width: 2),
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
        const Text(
          'Pas de compte ?',
          style: TextStyle(color: NOIR, fontSize: 17),
        ),
        const SizedBox(height: 20),
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
