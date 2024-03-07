import 'package:ape_manager_front/views/signup/signup_form_view.dart';
import 'package:ape_manager_front/widgets/conteneur/div_principale.dart';
import 'package:ape_manager_front/widgets/conteneur/header_div_principale.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

class SignupView extends StatelessWidget {
  static String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: DivPrincipale(
        header: HeaderDivPrincipale(ajouterBoutonRetour: true),
        maxWidth: 800,
        maxHeight: 1250,
        body: SignupFormView(),
      ),
    );
  }
}
