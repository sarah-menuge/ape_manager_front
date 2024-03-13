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
  final Function fetchOrganisateurs;

  const PopupSupprimerOrganisateur({
    super.key,
    required this.organisateur,
    required this.fetchOrganisateurs,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un organisateur",
      sousTitre: "Êtes-vous sûr de vouloir supprimer l'organisateur ?",
      body: SuppressionOrganisateurFormView(
        organisateur: organisateur,
        fetchOrganisateurs: fetchOrganisateurs,
      ),
    );
  }
}

class SuppressionOrganisateurFormView extends StatefulWidget {
  final Organisateur organisateur;
  final Function fetchOrganisateurs;

  const SuppressionOrganisateurFormView({
    super.key,
    required this.organisateur,
    required this.fetchOrganisateurs,
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
      supprimerOrganisateur();
    });
  }

  Future<void> supprimerOrganisateur() async {
    afficherLogCritical("Suppression d'un organisateur non pris en charge");
    return;
    final response = null;
    if (mounted && response["statusCode"] == 200) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchOrganisateurs();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
