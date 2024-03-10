import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSuppressionCommande extends StatelessWidget {
  const PopupSuppressionCommande({super.key});

  @override
  Widget build(BuildContext context) {
    return const Popup(
      intitule:
          'Suppression de la commande\nÊtes-vous sûr de vouloir supprimer votre commande ?',
      body: SuppressionCommandeFormView(),
    );
  }
}

class SuppressionCommandeFormView extends StatefulWidget {
  const SuppressionCommandeFormView({super.key});

  @override
  State<SuppressionCommandeFormView> createState() =>
      _SuppressionCommandeFormViewState();
}

class _SuppressionCommandeFormViewState
    extends FormulaireState<SuppressionCommandeFormView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [],
      boutons: [
        BoutonAction(
          text: "Annuler",
          fonction: () => Navigator.of(context).pop(),
          themeCouleur: ThemeCouleur.gris,
        ),
        BoutonAction(
          text: "Supprimer",
          fonction: () => print("Implementer suppression commande"),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }
}
