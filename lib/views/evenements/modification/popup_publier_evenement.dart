import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupPublierModifications extends StatelessWidget {
  final Evenement evenement;
  final Function fetchEvenements;

  const PopupPublierModifications({
    super.key,
    required this.evenement,
    required this.fetchEvenements,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Publication de l'évenement",
      sousTitre: "Êtes-vous sûr de vouloir publier l'évenement ?",
      body: PublicationEvenementFormView(
        evenement: evenement,
        fetchEvenements: fetchEvenements,
      ),
    );
  }
}

class PublicationEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function fetchEvenements;

  const PublicationEvenementFormView({
    super.key,
    required this.evenement,
    required this.fetchEvenements,
  });

  @override
  State<PublicationEvenementFormView> createState() =>
      _PublicationEvenementFormViewState();
}

class _PublicationEvenementFormViewState
    extends FormulaireState<PublicationEvenementFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Publier l'événement",
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
    afficherLogCritical("Publication d'un événement non pris en charge");
    return;
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
