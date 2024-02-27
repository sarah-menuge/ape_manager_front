import 'package:ape_manager_front/views/profile/popup_suppression_compte.dart';
import 'package:ape_manager_front/views/profile/popup_modification_mdp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/utilisateur.dart';
import '../../proprietes/couleurs.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';

class ModificationUtilisateurFormView extends StatefulWidget {
  const ModificationUtilisateurFormView({super.key});

  @override
  State<ModificationUtilisateurFormView> createState() =>
      _ModificationUtilisateurFormViewState();
}

class _ModificationUtilisateurFormViewState
    extends State<ModificationUtilisateurFormView> {
  final GlobalKey<FormState> modifFormKey = GlobalKey<FormState>();
  late Utilisateur utilisateurModifie;
  String? erreur;
  late bool readOnly = true;

  late UtilisateurProvider utilisateurProvider;

  FormState get form => modifFormKey.currentState!;

  @override
  void initState() {
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    utilisateurModifie = Utilisateur.copie(utilisateurProvider.utilisateur!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: modifFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getChampNom(),
                    const SizedBox(height: 30),
                    _getChampPrenom(),
                    const SizedBox(height: 30),
                    _getChampEmail(),
                    const SizedBox(height: 30),
                    _getChampTelephone(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getBoutonEditerSauvegarder(),
                const SizedBox(width: 30),
                _getBoutonSupprimerAnnuler(),
              ],
            ),
            const SizedBox(height: 20),
            _getBoutonModifierMdp(),
          ],
        ),
      ),
    );
  }

  Future<void> _envoiFormulaireModification() async {
    if (form.validate()) {
      form.save();

      final response = await utilisateurProvider
          .modifierInformationsUtilisateur(utilisateurModifie);
      if (response["statusCode"] == 200 && mounted) {
        afficherMessageSucces(
            context: context,
            message: "Les modifications ont bien été apportées.");
      } else {
        afficherMessageErreur(context: context, message: response["message"]);
      }
    }
    _switchEtatReadonly();
  }

  void _switchEtatReadonly() {
    setState(() {
      readOnly = !readOnly;
    });
  }

  Widget _getBoutonEditerSauvegarder() {
    return ElevatedButton(
      onPressed: () {
        // Demande pour éditer les infos du profil
        if (readOnly) {
          _switchEtatReadonly();
        }
        // Demande pour sauvegarder les modifications des infos du profil
        else {
          _envoiFormulaireModification();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
      child: Text(readOnly ? 'Modifier' : 'Sauvegarder'),
    );
  }

  Widget _getBoutonSupprimerAnnuler() {
    return ElevatedButton(
      onPressed: () {
        // Demande de suppression du compte
        if (readOnly) {
          showDialog(
            context: context,
            builder: (BuildContext context) => PopupSuppressionCompte(
                utilisateurProvider: utilisateurProvider),
          );
        }
        // Demande d'annulation des modifications
        else {
          setState(() {
            utilisateurModifie =
                Utilisateur.copie(utilisateurProvider.utilisateur!);
            _switchEtatReadonly();
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ROUGE,
        foregroundColor: BLANC,
      ),
      child: Text(readOnly ? 'Supprimer' : 'Annuler'),
    );
  }

  Widget _getBoutonModifierMdp() {
    return Center(
      child: TextButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => PopupModificationMdp(),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: ROUGE,
        ),
        child: const Text('Modifier mon mot de passe'),
      ),
    );
  }

  Widget _getChampNom() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) => utilisateurModifie.nom = value!,
        readOnly: readOnly,
        controller: utilisateurModifie.getNomController(),
        decoration: const InputDecoration(
          labelText: "Nom",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget _getChampPrenom() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) => utilisateurModifie.prenom = value!,
        readOnly: readOnly,
        controller: utilisateurModifie.getPrenomController(),
        decoration: const InputDecoration(
          labelText: "Prénom",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person_outline),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget _getChampEmail() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) => utilisateurModifie.email = value!,
        readOnly: readOnly,
        keyboardType: TextInputType.emailAddress,
        controller: utilisateurModifie.getEmailController(),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
            labelText: 'Email'),
        style: const TextStyle(height: 1),
      ),
    );
  }

  Widget _getChampTelephone() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: TextFormField(
        onSaved: (value) => utilisateurModifie.telephone = value!,
        readOnly: readOnly,
        keyboardType: TextInputType.phone,
        controller: utilisateurModifie.getTelephoneController(),
        decoration: const InputDecoration(
          labelText: "Téléphone",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone),
        ),
        style: const TextStyle(height: 1),
      ),
    );
  }
}
