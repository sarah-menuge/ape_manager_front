import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

import '../../models/evenement.dart';

class PopupEnregistrerModifications extends StatelessWidget {
  final Evenement evenement;
  final Function fetchEvenements;

  const PopupEnregistrerModifications({
    super.key,
    required this.evenement,
    required this.fetchEvenements,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      intitule:
      "Enregistrement des modifications.\n Êtes-vous sûr de vouloir enregistrer les modifications ?",
      body: EnregistrementEvenementFormView(
        evenement: evenement,
        fetchEvenements: fetchEvenements,
      ),
    );
  }
}

class EnregistrementEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function fetchEvenements;

  const EnregistrementEvenementFormView({
    super.key,
    required this.evenement,
    required this.fetchEvenements,
  });

  @override
  State<EnregistrementEvenementFormView> createState() =>
      _EnregistrementEvenementFormViewState();
}

class _EnregistrementEvenementFormViewState
    extends FormulaireState<EnregistrementEvenementFormView> {
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
          text: "Enregistrer",
          fonction: () => appuiBoutonAnnuler(),
          themeCouleur: ThemeCouleur.vert,
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
