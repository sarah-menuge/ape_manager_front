import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupModificationEnfant extends StatelessWidget {
  final Function fetchEnfants;
  final Enfant enfant;

  const PopupModificationEnfant(
      {super.key, required this.enfant, required this.fetchEnfants});

  @override
  Widget build(BuildContext context) {
    return Popup(
      intitule: "Veuillez renseigner les informations concernant votre enfant.",
      body: ModificationEnfantFormView(
        enfant: enfant,
        fetchEnfants: fetchEnfants,
      ),
    );
  }
}

class ModificationEnfantFormView extends StatefulWidget {
  final Function fetchEnfants;
  final Enfant enfant;

  const ModificationEnfantFormView(
      {super.key, required this.enfant, required this.fetchEnfants});

  @override
  State<ModificationEnfantFormView> createState() =>
      _ModificationEnfantFormViewState();
}

class _ModificationEnfantFormViewState
    extends FormulaireState<ModificationEnfantFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            prefixIcon: const Icon(Icons.person),
            label: "Nom de l'enfant",
            valeurInitiale: widget.enfant.nom,
            onSavedMethod: (value) => widget.enfant.nom = value!,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.person_outline),
            label: "Prénom de l'enfant",
            valeurInitiale: widget.enfant.prenom,
            onSavedMethod: (value) => widget.enfant.prenom = value!,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.school),
            label: "Classe de l'enfant",
            valeurInitiale: widget.enfant.classe,
            onSavedMethod: (value) => widget.enfant.classe = value!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Modifier",
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
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    final response = await utilisateurProvider.modifierEnfant(widget.enfant);
    if (response["statusCode"] == 200 && mounted) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchEnfants();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
