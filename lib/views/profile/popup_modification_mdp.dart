import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../forms/modification_mdp_form.dart';
import '../../proprietes/couleurs.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';

class PopupModificationMdp extends StatelessWidget {
  const PopupModificationMdp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = 600;
          return SingleChildScrollView(
            child: Container(
              width: constraints.maxWidth > maxWidth
                  ? maxWidth
                  : constraints.maxWidth,
              padding: const EdgeInsets.all(20.0),
              child: ModificationMdpFormView(),
            ),
          );
        },
      ),
    );
  }
}

class ModificationMdpFormView extends StatefulWidget {
  const ModificationMdpFormView({super.key});

  @override
  State<ModificationMdpFormView> createState() =>
      _ModificationMdpFormViewState();
}

class _ModificationMdpFormViewState extends State<ModificationMdpFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ModificationMdpForm modifMdpForm;
  String? erreur;
  late bool readOnly = true;

  late UtilisateurProvider utilisateurProvider;

  FormState get form => formKey.currentState!;

  @override
  void initState() {
    modifMdpForm = ModificationMdpForm();
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
        children: [
          getFlecheRetour(),
          Image.asset('assets/images/logoEcole.png', width: 80, height: 80),
          const SizedBox(height: 12),
          getLogo(),
          getMessageErreur(),
          getEmail(),
          const SizedBox(height: 10),
          getAncienMdp(),
          const SizedBox(height: 10),
          getNouveauMdp(),
          const SizedBox(height: 10),
          getConfirmerNouveauMdp(),
          const SizedBox(height: 20),
          getBoutonValider(),
        ],
      ),
    );
  }

  Widget getFlecheRetour() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        const Text('Retour'),
      ],
    );
  }

  Widget getLogo() {
    return const Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Association des parents d\'élèves \n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'École et Collège\nSte Marie Perenchies',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget getEmail() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          modifMdpForm.email = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner ce champ';
          }
          /* else if (value != utilisateurProvider.utilisateur?.email) {
            return 'Veuillez saisir votre propre adresse email.';
          }*/
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

  Widget getAncienMdp() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          modifMdpForm.oldPassword = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Ancien Mot de passe',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getNouveauMdp() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          modifMdpForm.newPassword = value!;
        },
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

  Widget getConfirmerNouveauMdp() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) {
          modifMdpForm.confirmerNewPassword = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          /*if (value != modifMdpForm.newPassword) {
            return 'Les deux mots de passe ne sont pas identiques.';
          }*/
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Confirmer nouveau Mot de passe',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget getBoutonValider() {
    return ElevatedButton(
      onPressed: () => _envoiFormulaireModificationMdp(),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
        minimumSize: const Size(200, 50),
      ),
      child: const Text('Valider'),
    );
  }

  Future<void> _envoiFormulaireModificationMdp() async {
    if (form.validate()) {
      form.save();
      setState(() {
        erreur = "";
      });

      // Controle newMdp = confirmNewMdp
      if (modifMdpForm.newPassword != modifMdpForm.confirmerNewPassword) {
        setState(() {
          erreur = "Les deux mots de passe ne correspondent pas.";
        });
        return;
      }

      final response =
          await utilisateurProvider.modifierMotDePasse(modifMdpForm);
      if (response["statusCode"] == 200 && mounted) {
        afficherMessageSucces(
            context: context, message: "Le mot de passe a bien été modifié.");
      } else {
        setState(() {
          erreur = response["message"];
        });
      }
    }
  }
}
