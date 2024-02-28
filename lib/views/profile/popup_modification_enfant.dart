import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupModificationEnfant extends StatelessWidget {
  const PopupModificationEnfant({super.key});

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
              child: ModificationEnfantFormView(),
            ),
          );
        },
      ),
    );
  }
}

class ModificationEnfantFormView extends StatefulWidget {
  const ModificationEnfantFormView({super.key});

  @override
  State<ModificationEnfantFormView> createState() =>
      _ModificationEnfantFormViewState();
}

class _ModificationEnfantFormViewState
    extends State<ModificationEnfantFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? erreur;
  Enfant enfant = Enfant();

  late UtilisateurProvider utilisateurProvider;

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
        children: [
          getFlecheRetour(),
          getMessageErreur(),

          ///
          /// Ajouter les autres champs
          ///
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

  Widget getBoutonValider() {
    return ElevatedButton(
      onPressed: () => _envoiFormulaire(),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
        minimumSize: const Size(200, 50),
      ),
      child: const Text('Modifier'),
    );
  }

  Future<void> _envoiFormulaire() async {
    if (form.validate()) {
      form.save();
      final response = await utilisateurProvider.modifierEnfant(enfant);
      if (response["statusCode"] == 200 && mounted) {
        afficherMessageSucces(
            context: context,
            message: "Les informations de l'enfant ont bien été modifiées.");
      } else {
        setState(() => erreur = response["message"]);
      }
    }
  }
}
