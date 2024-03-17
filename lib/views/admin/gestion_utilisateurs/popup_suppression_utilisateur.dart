import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSuppressionUtilisateur extends StatelessWidget {
  final Utilisateur utilisateur;
  final Function fetchUtilisateurs;

  const PopupSuppressionUtilisateur({
    super.key,
    required this.utilisateur,
    required this.fetchUtilisateurs,
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
      ),
    );
  }
}

class SuppressionUtilisateurFormView extends StatefulWidget {
  final Utilisateur utilisateur;
  final Function fetchUtilisateurs;

  const SuppressionUtilisateurFormView({
    super.key,
    required this.utilisateur,
    required this.fetchUtilisateurs,
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
      supprimerUtilisateur();
    });
  }

  Future<void> supprimerUtilisateur() async {
    afficherLogCritical("Suppression d'un utilisateur non pris en charge");
  }
}
