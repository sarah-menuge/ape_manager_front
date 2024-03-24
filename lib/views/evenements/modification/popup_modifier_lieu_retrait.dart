import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupModifierLieuRetrait extends StatelessWidget {
  final Function modifierLieuRetrait;
  final LieuRetrait lieuRetrait;

  const PopupModifierLieuRetrait({
    super.key,
    required this.modifierLieuRetrait,
    required this.lieuRetrait,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Modification d'un lieu de retrait",
      sousTitre:
          "Veuillez renseigner les informations concernant le lieu de retrait à modifier.",
      body: ModifierLieuRetraitFormView(
        modifierLieuRetrait: modifierLieuRetrait,
        lieuRetrait: lieuRetrait,
      ),
    );
  }
}

class ModifierLieuRetraitFormView extends StatefulWidget {
  final Function modifierLieuRetrait;
  final LieuRetrait lieuRetrait;

  const ModifierLieuRetraitFormView({
    super.key,
    required this.modifierLieuRetrait,
    required this.lieuRetrait,
  });

  @override
  State<ModifierLieuRetraitFormView> createState() =>
      _ModifierLieuRetraitFormViewState();
}

class _ModifierLieuRetraitFormViewState
    extends FormulaireState<ModifierLieuRetraitFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            prefixIcon: const Icon(Icons.abc),
            label: "Lieu de retrait",
            valeurInitiale: widget.lieuRetrait.lieu,
            onSavedMethod: (value) => widget.lieuRetrait.lieu = value!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Modifier le lieu de retrait",
          fonction: () => appuiBoutonModifier(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonModifier() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        widget.modifierLieuRetrait(widget.lieuRetrait);
      });
    }
  }
}
