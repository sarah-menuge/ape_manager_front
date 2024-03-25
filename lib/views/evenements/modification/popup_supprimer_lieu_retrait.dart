import 'package:ape_manager_front/models/lieu_retrait.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSupprimerLieuRetrait extends StatelessWidget {
  final Function supprimerLieuRetrait;
  final LieuRetrait lieuRetrait;

  const PopupSupprimerLieuRetrait({
    super.key,
    required this.supprimerLieuRetrait,
    required this.lieuRetrait,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un lieu de retrait",
      sousTitre:
          "Vous vous apprêtez à supprimer le lieu de retrait ${lieuRetrait.lieu}.",
      body: SupprimerLieuRetraitFormView(
        supprimerLieuRetrait: supprimerLieuRetrait,
        lieuRetrait: lieuRetrait,
      ),
    );
  }
}

class SupprimerLieuRetraitFormView extends StatefulWidget {
  final Function supprimerLieuRetrait;
  final LieuRetrait lieuRetrait;

  const SupprimerLieuRetraitFormView({
    super.key,
    required this.supprimerLieuRetrait,
    required this.lieuRetrait,
  });

  @override
  State<SupprimerLieuRetraitFormView> createState() =>
      _SupprimerLieuRetraitFormViewState();
}

class _SupprimerLieuRetraitFormViewState
    extends FormulaireState<SupprimerLieuRetraitFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [],
      boutons: [
        BoutonAction(
          text: "Supprimer le lieu de retrait",
          fonction: () => appuiBoutonSupprimer(),
          disable: desactiverBoutons,
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        widget.supprimerLieuRetrait(widget.lieuRetrait);
      });
    }
  }
}
