import 'package:ape_manager_front/providers/authentification_provider.dart';
import '../../forms/signup_form.dart';
import '../../proprietes/couleurs.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';
import '../profile/profile_view.dart';

class SignupFormView extends StatefulWidget {
  const SignupFormView({super.key});

  @override
  State<SignupFormView> createState() => _SignupFormViewState();
}

class _SignupFormViewState extends State<SignupFormView> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  late SignupForm signupForm;
  String? erreur;

  late AuthentificationProvider authentificationProvider;

  FormState get form => signupFormKey.currentState!;

  @override
  void initState() {
    signupForm = SignupForm.vide();
    authentificationProvider =
        Provider.of<AuthentificationProvider>(context, listen: false);
    super.initState();
  }

  Future<void> envoiFormulaireSignup() async {
    if (form.validate()) {
      form.save();
      final response = await authentificationProvider.signup(
        signupForm,
        Provider.of<UtilisateurProvider>(context, listen: false),
      );
      if (response["statusCode"] == 200 && mounted) {
        Navigator.pushReplacementNamed(context, ProfileView.routeName);
        afficherMessageSucces(
            context: context, message: "Compte créé avec succès.");
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
        // isLoading == true ? const Loader() : const SizedBox(),
        Form(
          key: signupFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                getMessageErreur(),
                const SizedBox(height: 30),
                getChampNom(),
                const SizedBox(height: 20),
                getChampPrenom(),
                const SizedBox(height: 20),
                getChampEmail(),
                const SizedBox(height: 20),
                getChampTelephone(),
                const SizedBox(height: 20),
                getChampMotDePasse(),
                const SizedBox(height: 20),
                getBoutonSignup(),
              ],
            ),
          ),
        )
      ],
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

  Widget getChampNom() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          signupForm.nom = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Nom',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getChampPrenom() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          signupForm.prenom = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Prénom',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person_outline),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getChampEmail() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          signupForm.email = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          } else if (!value.contains('@')) {
            return "L'email renseigné n'est pas valide.";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getChampTelephone() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (value) {
          signupForm.telephone = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Téléphone',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getChampMotDePasse() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          signupForm.password = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Mot de passe',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getBoutonSignup() {
    bool isLoggedIn = authentificationProvider.isLoggedIn;
    bool isLoading = authentificationProvider.isLoading;

    return ElevatedButton(
      onPressed: () {
        if (isLoading == false && isLoggedIn == false) {
          envoiFormulaireSignup();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
      child: const Text('Valider'),
    );
  }
}
