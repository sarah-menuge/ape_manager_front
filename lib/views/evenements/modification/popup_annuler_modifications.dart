import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAnnulerModifications extends StatelessWidget {
  final Function annulerModificationsInfosGenerales;

  const PopupAnnulerModifications({
    super.key,
    required this.annulerModificationsInfosGenerales,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Annulation des modifications",
      sousTitre: "Êtes-vous sûr de vouloir annuler les modifications ?",
      body: SuppressionEvenementFormView(
        annulerModificationsInfosGenerales: annulerModificationsInfosGenerales,
      ),
    );
  }
}

class SuppressionEvenementFormView extends StatefulWidget {
  final Function annulerModificationsInfosGenerales;

  const SuppressionEvenementFormView({
    super.key,
    required this.annulerModificationsInfosGenerales,
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
      paddingFormulaire: const EdgeInsets.only(top: 0),
      boutons: [
        BoutonAction(
          text: "Annuler les modifications",
          fonction: () => appuiBoutonAnnuler(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonAnnuler() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      widget.annulerModificationsInfosGenerales();
    });
  }
}
