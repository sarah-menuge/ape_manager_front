import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

import '../../models/evenement.dart';

class PopupAnnulerModifications extends StatelessWidget {
  final Evenement evenement;
  final Function fetchEvenements;

  const PopupAnnulerModifications({
    super.key,
    required this.evenement,
    required this.fetchEvenements,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      intitule:
      "Annulation des modifications.\n Êtes-vous sûr de vouloir annuler les modifications ?",
      body: SuppressionEvenementFormView(
        evenement: evenement,
        fetchEvenements: fetchEvenements,
      ),
    );
  }
}

class SuppressionEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function fetchEvenements;

  const SuppressionEvenementFormView({
    super.key,
    required this.evenement,
    required this.fetchEvenements,
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
          text: "Retour",
          fonction: () => Navigator.of(context).pop(),
          themeCouleur: ThemeCouleur.gris,
        ),
        BoutonAction(
          text: "Annuler",
          fonction: () => appuiBoutonAnnuler(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonAnnuler() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      annulerEvenement();
    });
  }

  Future<void> annulerEvenement() async {
    final response = null;
    if (mounted && response["statusCode"] == 200) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchEvenements();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
