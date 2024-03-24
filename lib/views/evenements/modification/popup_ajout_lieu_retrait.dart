import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAjouterLieuRetrait extends StatelessWidget {
  final Function ajouterLieuRetrait;

  const PopupAjouterLieuRetrait({
    super.key,
    required this.ajouterLieuRetrait,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Ajout d'un lieu de retrait",
      sousTitre:
          "Veuillez renseigner les informations concernant le lieu de retrait à ajouter.",
      body: AjouterLieuRetraitFormView(
        ajouterLieuRetrait: ajouterLieuRetrait,
      ),
    );
  }
}

class AjouterLieuRetraitFormView extends StatefulWidget {
  final Function ajouterLieuRetrait;
  final LieuRetrait lieuRetrait = LieuRetrait();

  AjouterLieuRetraitFormView({
    super.key,
    required this.ajouterLieuRetrait,
  });

  @override
  State<AjouterLieuRetraitFormView> createState() =>
      _AjouterLieuRetraitFormViewState();
}

class _AjouterLieuRetraitFormViewState
    extends FormulaireState<AjouterLieuRetraitFormView> {
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
          text: "Ajouter le lieu de retrait",
          fonction: () => appuiBoutonAjouter(),
          disable: desactiverBoutons,
          themeCouleur: ThemeCouleur.vert,
        ),
      ],
    );
  }

  void appuiBoutonAjouter() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        widget.ajouterLieuRetrait(widget.lieuRetrait);
      });
    }
  }
}
