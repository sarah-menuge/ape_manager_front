import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class CreerEvenementFormView extends StatefulWidget {
  const CreerEvenementFormView({super.key});

  @override
  State<CreerEvenementFormView> createState() => _CreerEvenementFormViewState();
}

class _CreerEvenementFormViewState extends FormulaireState<CreerEvenementFormView> {

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            label: "Titre de l'événement",
            prefixIcon: const Icon(Icons.title),
          ),
        ],
      ], boutons: [],
    );
  }
}