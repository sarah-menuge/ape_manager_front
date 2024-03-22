import 'package:ape_manager_front/views/authentification/login/login_view.dart';
import 'package:ape_manager_front/views/authentification/signup/signup_form_view.dart';
import 'package:ape_manager_front/widgets/conteneur/div_principale.dart';
import 'package:ape_manager_front/widgets/conteneur/header_div_principale.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

class SignupView extends StatelessWidget {
  static String routeURL = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: DefaultTextStyle(
        style: const TextStyle(fontFamilyFallback: ['Roboto']),
        child: DivPrincipale(
          header: const HeaderDivPrincipale(ajouterBoutonRetour: true),
          maxWidth: 800,
          maxHeight: 1250,
          body: const SignupFormView(),
          nomUrlRetour: LoginView.routeURL,
        ),
      ),
    );
  }
}
