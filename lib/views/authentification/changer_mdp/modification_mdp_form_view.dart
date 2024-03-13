import 'package:ape_manager_front/forms/reinit_mdp_form.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/views/authentification/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModificationMdpFormView extends StatefulWidget {
  const ModificationMdpFormView({super.key});

  @override
  State<ModificationMdpFormView> createState() =>
      _ModificationMdpFormViewState();
}

class _ModificationMdpFormViewState extends State<ModificationMdpFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? erreur;

  late UtilisateurProvider utilisateurProvider;
  late ReinitMdpForm reinitMdpForm = ReinitMdpForm();

  FormState get form => formKey.currentState!;

  @override
  void initState() {
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _getBoutonRetour(),
          _getLogo(),
          getMessageErreur(),
          _getChampEmail(),
          const SizedBox(height: 20),
          _getChampNouveauMdp(),
          const SizedBox(height: 20),
          _getChampConfirmerNouveauMdp(),
          const SizedBox(height: 20),
          _getBoutonModifier(),
        ],
      ),
    );
  }

  Widget _getBoutonRetour() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, LoginView.routeURL)),
      ],
    );
  }

  Widget _getBoutonModifier() {
    return ElevatedButton(
      onPressed: () => _validerFormulaire(),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
      child: const Text('Valider'),
    );
  }

  _validerFormulaire() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final response = await utilisateurProvider.reinitMdp(reinitMdpForm);
      if (response["statusCode"] == 200 && mounted) {
        Navigator.of(context).pop();
        afficherMessageSucces(
            context: context, message: "Le mot de passe a bien été modifié.");
      } else {
        setState(() {
          erreur = response['message'];
        });
      }
    } else {
      print("KO");
    }
  }

  Widget _getLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child:
              Image.asset('assets/images/logoEcole.png', width: 80, height: 80),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Association des parents d\'élèves \n',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'École et Collège\nSte Marie Perenchies',
                    style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getChampEmail() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email address';
          } else if (!value.contains('@')) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget _getChampNouveauMdp() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Nouveau Mot de passe',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget _getChampConfirmerNouveauMdp() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Confirmez Mot de passe',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
        ),
        style: const TextStyle(height: 1),
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
}
