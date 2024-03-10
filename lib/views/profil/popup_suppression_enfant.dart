import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSuppressionEnfant extends StatelessWidget {
  final Enfant enfant;
  final Function fetchEnfants;

  const PopupSuppressionEnfant({
    super.key,
    required this.enfant,
    required this.fetchEnfants,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      intitule:
          "Suppression d'un enfant.\n Êtes-vous sûr de vouloir supprimer l'enfant ?",
      body: SuppressionEnfantFormView(
        enfant: enfant,
        fetchEnfants: fetchEnfants,
      ),
    );
  }
}

class SuppressionEnfantFormView extends StatefulWidget {
  final Enfant enfant;
  final Function fetchEnfants;

  const SuppressionEnfantFormView({
    super.key,
    required this.enfant,
    required this.fetchEnfants,
  });

  @override
  State<SuppressionEnfantFormView> createState() =>
      _SuppressionEnfantFormViewState();
}

class _SuppressionEnfantFormViewState
    extends FormulaireState<SuppressionEnfantFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Annuler",
          fonction: () => Navigator.of(context).pop(),
          themeCouleur: ThemeCouleur.gris,
        ),
        BoutonAction(
          text: "Supprimer",
          fonction: () => appuiBoutonSupprimer(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      supprimerEnfant();
    });
  }

  Future<void> supprimerEnfant() async {
    final response = await utilisateurProvider.supprimerEnfant(
      utilisateurProvider.token!,
      widget.enfant,
    );
    if (mounted && response["statusCode"] == 200) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchEnfants();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
