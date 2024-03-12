import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

import '../../widgets/formulaire/champ_date.dart';

class ModifierEvenementFormView extends StatefulWidget {
  const ModifierEvenementFormView({super.key});

  @override
  State<ModifierEvenementFormView> createState() =>
      _ModifierEvenementFormViewState();
}

class _ModifierEvenementFormViewState
    extends FormulaireState<ModifierEvenementFormView> {
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
        [
          ChampString(
            label: "Description de l'événement",
            prefixIcon: const Icon(Icons.description),
          ),
        ],
        [
          ChampSelectSimple(
            label: "Lieu de retrait",
            prefixIcon: const Icon(Icons.location_on),
            valeursExistantes: [
              "Lieu 1",
              "Lieu 2",
              "Lieu 3",
              "Lieu 4",
            ],
          ),
          ChampDate(
            readOnly: false,
            prefixIcon: const Icon(Icons.calendar_today),
            label: "Date de début des commandes",
          ),
        ],
        [
          ChampDate(
            readOnly: false,
            prefixIcon: const Icon(Icons.calendar_today),
            label: "Date de fin de paiement",
          ),
          ChampDate(
            readOnly: false,
            prefixIcon: const Icon(Icons.calendar_today),
            label: "Date de fin de l'événement",
          ),
        ],
      ],
      boutons: [],
    );
  }
}
