import 'package:ape_manager_front/forms/login_form.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/login/reinitialisation_form_view.dart';
import 'package:ape_manager_front/views/login/signup_button.dart';
import '../../proprietes/constantes.dart';
import '../../proprietes/couleurs.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';
import '../../widgets/loader.dart';
import '../accueil/accueil_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late LoginForm loginForm;
  String? erreur;
  bool passerVerification = false;

  late AuthentificationProvider authentificationProvider;

  FormState get form => loginFormKey.currentState!;

  @override
  void initState() {
    loginForm = LoginForm(
      email: "",
      password: "",
    );
    authentificationProvider =
        Provider.of<AuthentificationProvider>(context, listen: false);

    // Permet l'autologin dans un environnement hors production
    if (PROD == "false" && AUTO_LOGIN_TEST == "true") {
      loginForm.email = EMAIL_AUTO_LOGIN_TEST;
      loginForm.password = PASSWORD_AUTO_LOGIN_TEST;
      passerVerification = true;
      _envoiFormulaireLogin();
    }
    super.initState();
  }

  Future<void> _envoiFormulaireLogin() async {
    if (passerVerification == true || form.validate()) {
      if (passerVerification == false) form.save();
      final response = await authentificationProvider.signin(
        loginForm,
        Provider.of<UtilisateurProvider>(context, listen: false),
      );
      if (response["statusCode"] == 200 && mounted) {
        Navigator.pushReplacementNamed(context, AccueilView.routeName);
        afficherMessageSucces(
            context: context, message: "Connexion établie avec succès.");
      } else {
        setState(() {
          erreur = response['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = authentificationProvider.isLoading;
    return Stack(
      children: [
        isLoading == true ? const Loader() : const SizedBox(),
        Form(
          key: loginFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                getMessageErreur(),
                getEmailInput(),
                const SizedBox(height: 20),
                getPasswordInput(),
                getForgotPasswordText(),
                ResponsiveLayout(
                  mobileBody: getBoutonsMobile(),
                  desktopBody: getBoutonsDesktop(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getEmailInput() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: TextFormField(
        onSaved: (value) {
          loginForm.email = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(height: 1),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget getPasswordInput() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: TextFormField(
        onSaved: (value) {
          loginForm.password = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Mot de passe',
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(height: 1),
        obscureText: true,
      ),
    );
  }

  Widget getForgotPasswordText() {
    return SizedBox(
      width: 300,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            _showForgotPasswordDialog(context);
          },
          child: Text(
            'Mot de passe oublié ?',
            style: FontUtils.getFontApp(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget getMessageErreur() {
    if (erreur == null) {
      return const SizedBox(height: 40);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Text(
          erreur!,
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.red[900]),
        ),
      );
    }
  }

  Widget getBoutonsMobile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getBoutonLogin(),
        SignUpButton(),
      ],
    );
  }

  Widget getBoutonsDesktop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getBoutonLogin(),
      ],
    );
  }

  Widget getBoutonLogin() {
    bool isLoggedIn = authentificationProvider.isLoggedIn;
    bool isLoading = authentificationProvider.isLoading;
    return ElevatedButton(
      onPressed: () {
        if (isLoading == false && isLoggedIn == false) {
          _envoiFormulaireLogin();
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: BLANC,
        backgroundColor: BLEU,
      ),
      child: const Text('Se connecter'),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BEIGE_CLAIR.withOpacity(1.0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Veuillez entrer votre mail pour demander une réinitialisation du mot de passe",
                  style: FontUtils.getFontApp(fontSize: 15),
                ),
                const SizedBox(height: 20),
                ReinitialisationFormView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
