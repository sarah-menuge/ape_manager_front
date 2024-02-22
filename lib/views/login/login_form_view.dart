import 'package:ape_manager_front/forms/login_form.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/login/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../proprietes/couleurs.dart';
import '../../widgets/loader.dart';
import '../accueil/accueil_view.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late LoginForm loginForm;
  String? erreur;

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
    super.initState();
  }

  Future<void> envoiFormulaireLogin() async {
    print("token : ${authentificationProvider.token}");
    if (form.validate()) {
      form.save();
      setState(() {
        authentificationProvider.isLoading = true;
      });
      final response = await authentificationProvider.signin(loginForm);
      if (response["statusCode"] == 200 && mounted) {
        Navigator.pushReplacementNamed(context, AccueilView.routeName);
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
    isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
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
          onPressed: () {},
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
          envoiFormulaireLogin();
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: BLANC,
        backgroundColor: BLEU,
      ),
      child: const Text('Se connecter'),
    );
  }
}
