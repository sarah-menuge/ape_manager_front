import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../forms/reinitialisation_form.dart';
import '../../proprietes/couleurs.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';

class ReinitialisationFormView extends StatefulWidget {
  const ReinitialisationFormView({super.key});

  @override
  State<ReinitialisationFormView> createState() =>
      _ReinitialisationFormViewState();
}

class _ReinitialisationFormViewState extends State<ReinitialisationFormView> {
  final GlobalKey<FormState> reinitFormKey = GlobalKey<FormState>();
  late ReinitialisationForm reinitForm;
  String? erreur;

  late UtilisateurProvider utilisateurProvider;

  FormState get form => reinitFormKey.currentState!;

  @override
  void initState() {
    reinitForm = ReinitialisationForm(email: '');
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    super.initState();
  }

  Future<void> _envoiFormulaireReinitialisation() async {
    print("ENVOI FORMULAIRE REINITIALISATION");
    if (form.validate()) {
      form.save();
      // afficherMessageErreur(context: context, message: "Envoi formulaire de réinitialisation non géré.");
      final response =
          await utilisateurProvider.reinitialiserMotDePasse(reinitForm);
      if (response["statusCode"] == 200 && mounted) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          erreur = response['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: reinitFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getMessageErreur(),
          getChampEmail(),
          getBoutonEnvoyer(),
        ],
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

  Widget getChampEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: TextFormField(
          onSaved: (value) {
            reinitForm.email = value!;
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
            prefixIcon: Icon(Icons.mail),
          ),
          style: const TextStyle(height: 1),
        ),
      ),
    );
  }

  Widget getBoutonEnvoyer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: BLEU,
        ),
        child: const Text("Envoyer", style: TextStyle(color: BLANC)),
        onPressed: () {
          _envoiFormulaireReinitialisation();
        },
      ),
    );
  }
}
