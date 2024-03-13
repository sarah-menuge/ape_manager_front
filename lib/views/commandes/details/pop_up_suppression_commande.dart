import 'package:ape_manager_front/utils/logs.dart';
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
      titre: "Suppression d'une commande",
      sousTitre: "Êtes-vous sûr de vouloir supprimer votre commande ?",
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
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [],
      boutons: [
        BoutonAction(
          text: "Supprimer la commande",
          fonction: () =>
              afficherLogCritical("Suppression d'une commande non implémentée"),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }
}
