import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSuppressionUtilisateur extends StatelessWidget {
  final Utilisateur utilisateur;
  final Function fetchUtilisateurs;
  final Function fonctionSuppression;

  const PopupSuppressionUtilisateur({
    super.key,
    required this.utilisateur,
    required this.fetchUtilisateurs,
    required this.fonctionSuppression,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un utilisateur",
      sousTitre:
          "Êtes-vous sûr de vouloir supprimer l'utilisateur ${utilisateur.prenom} ${utilisateur.nom} ?",
      body: SuppressionUtilisateurFormView(
        utilisateur: utilisateur,
        fetchUtilisateurs: fetchUtilisateurs,
        fonctionSuppression: fonctionSuppression,
      ),
    );
  }
}

class SuppressionUtilisateurFormView extends StatefulWidget {
  final Utilisateur utilisateur;
  final Function fetchUtilisateurs;
  final Function fonctionSuppression;

  const SuppressionUtilisateurFormView({
    super.key,
    required this.utilisateur,
    required this.fetchUtilisateurs,
    required this.fonctionSuppression,
  });

  @override
  State<SuppressionUtilisateurFormView> createState() =>
      _SuppressionUtilisateurFormViewState();
}

class _SuppressionUtilisateurFormViewState
    extends FormulaireState<SuppressionUtilisateurFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Supprimer l'utilisateur",
          fonction: () => appuiBoutonSupprimer(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      widget.fonctionSuppression(widget.utilisateur.id);
    });
  }
}
