import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSupprimerEvenement extends StatelessWidget {
  final Evenement evenement;
  final Function supprimerEvenement;

  const PopupSupprimerEvenement({
    super.key,
    required this.evenement,
    required this.supprimerEvenement,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un événement",
      sousTitre:
          "Vous vous apprêtez à supprimer l'événement ${evenement.titre}.",
      body: SuppressionEvenementFormView(
        evenement: evenement,
        supprimerEvenement: supprimerEvenement,
      ),
    );
  }
}

class SuppressionEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function supprimerEvenement;

  const SuppressionEvenementFormView({
    super.key,
    required this.evenement,
    required this.supprimerEvenement,
  });

  @override
  State<SuppressionEvenementFormView> createState() =>
      _SuppressionEvenementFormViewState();
}

class _SuppressionEvenementFormViewState
    extends FormulaireState<SuppressionEvenementFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Supprimer l'événement",
          fonction: () => appuiBoutonSupprimer(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      widget.supprimerEvenement();
    });
  }
}
