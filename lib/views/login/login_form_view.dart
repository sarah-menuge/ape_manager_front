import 'package:ape_manager_front/forms/login_form.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/login/demande_reinit_form_view.dart';
import 'package:ape_manager_front/views/signup/signup_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_email.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_mdp.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import '../../proprietes/constantes.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';
import '../accueil/accueil_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends FormulaireState<LoginFormView> {
  late AuthentificationProvider authentificationProvider;
  late LoginForm loginForm = LoginForm();
  bool passerVerification = false;

  @override
  void initState() {
    super.initState();
    authentificationProvider =
        Provider.of<AuthentificationProvider>(context, listen: false);

    // Permet l'autologin dans un environnement hors production
    if (PROD == "false" && AUTO_LOGIN_TEST == "true") {
      loginForm.email = EMAIL_AUTO_LOGIN_TEST;
      loginForm.password = PASSWORD_AUTO_LOGIN_TEST;
      passerVerification = true;
      appuiBoutonLogin();
    }
  }

  @override
  Formulaire setFormulaire(BuildContext context) {
    bool isLoggedIn = authentificationProvider.isLoggedIn;
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      contenuManuel: getTexteMdpOublie(),
      forcerBoutonsEnColonneSurMobile: false,
      champs: [
        [
          ChampEmail(
            label: "Votre email",
            onSavedMethod: (value) => loginForm.email = value!,
          ),
        ],
        [
          ChampMdp(
            label: "Votre mot de passe",
            onSavedMethod: (value) => loginForm.password = value!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Se connecter",
          fonction: () => appuiBoutonLogin(),
          disable: desactiverBoutons || isLoggedIn,
        ),
        if (estMobile(context, 600))
          BoutonNavigationGoRouter(
            text: "S'inscrire",
            themeCouleur: ThemeCouleur.rouge,
            routeName: SignupView.routeURL,
            disable: desactiverBoutons || isLoggedIn,
          ),
      ],
    );
  }

  void appuiBoutonLogin() {
    if (!chargement &&
        (passerVerification == true || formKey.currentState!.validate())) {
      if (passerVerification == false) {
        formKey.currentState!.save();
      } else {
        passerVerification = false;
      }
      appelMethodeAsynchrone(() {
        envoiFormulaireLogin();
      });
    }
  }

  Future<void> envoiFormulaireLogin() async {
    final response = await authentificationProvider.signin(
      loginForm,
      Provider.of<UtilisateurProvider>(context, listen: false),
    );
    if (response["statusCode"] == 200 && mounted) {
      naviguerVersPage(context, AccueilView.routeURL);
      afficherMessageSucces(
          context: context, message: "Connexion établie avec succès.");
    } else {
      setMessageErreur(response['message']);
    }
  }

  Widget getTexteMdpOublie() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => getPopupMdpOublie(),
              );
            },
            child: Text(
              'Mot de passe oublié ?',
              style: FontUtils.getFontApp(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget getPopupMdpOublie() {
    return const Popup(
      intitule:
          "Veuillez entrer votre mail pour demander une réinitialisation du mot de passe",
      body: DemandeReinitMdpFormView(),
    );
  }
}
