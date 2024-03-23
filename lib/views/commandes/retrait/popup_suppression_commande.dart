import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSuppressionCommande extends StatelessWidget {
  final Commande commande;
  final Function fetchCommandes;

  const PopupSuppressionCommande({
    super.key,
    required this.commande,
    required this.fetchCommandes,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'une commande",
      sousTitre:
      "Êtes-vous sûr de vouloir supprimer la commande n°${commande.id} ?",
      body: SuppressionCommandeFormView(
        commande: commande,
        fetchCommandes: fetchCommandes,
      ),
    );
  }
}

class SuppressionCommandeFormView extends StatefulWidget {
  final Commande commande;
  final Function fetchCommandes;

  const SuppressionCommandeFormView({
    super.key,
    required this.commande,
    required this.fetchCommandes,
  });

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
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Supprimer la commande",
          fonction: () => appuiBoutonSupprimer(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      supprimerCommande();
    });
  }

  Future<void> supprimerCommande() async {
    afficherLogCritical("Suppression d'une commande non pris en charge");
  }
}
