import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSupprimerOrganisateur extends StatelessWidget {
  final Organisateur organisateur;
  final Function supprimerOrganisateur;

  const PopupSupprimerOrganisateur({
    super.key,
    required this.organisateur,
    required this.supprimerOrganisateur,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un organisateur",
      sousTitre: "Êtes-vous sûr de vouloir supprimer l'organisateur ?",
      body: SuppressionOrganisateurFormView(
        organisateur: organisateur,
        supprimerOrganisateur: supprimerOrganisateur,
      ),
    );
  }
}

class SuppressionOrganisateurFormView extends StatefulWidget {
  final Organisateur organisateur;
  final Function supprimerOrganisateur;

  const SuppressionOrganisateurFormView({
    super.key,
    required this.organisateur,
    required this.supprimerOrganisateur,
  });

  @override
  State<SuppressionOrganisateurFormView> createState() =>
      _SuppressionOrganisateurFormViewState();
}

class _SuppressionOrganisateurFormViewState
    extends FormulaireState<SuppressionOrganisateurFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Supprimer l'organisateur",
          fonction: () => appuiBoutonSupprimer(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      widget.supprimerOrganisateur(widget.organisateur);
    });
  }
}
