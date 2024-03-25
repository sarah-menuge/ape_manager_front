import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSuppressionOrganisateur extends StatelessWidget {
  final Organisateur organisateur;
  final Function supprimerOrganisateur;

  const PopupSuppressionOrganisateur({
    super.key,
    required this.organisateur,
    required this.supprimerOrganisateur,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Retirer un organisateur de la liste",
      sousTitre:
          "Vous vous apprêtez à retirer l'organisateur ${organisateur.toString()} de la liste.",
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
          text: "Retirer l'organisateur de la liste",
          fonction: () => widget.supprimerOrganisateur(widget.organisateur),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }
}
