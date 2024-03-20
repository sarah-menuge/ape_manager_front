import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupPublierModifications extends StatelessWidget {
  final Evenement evenement;
  final Function publierEvenement;

  const PopupPublierModifications({
    super.key,
    required this.evenement,
    required this.publierEvenement,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Publication de l'évenement",
      sousTitre: "Êtes-vous sûr de vouloir publier l'évenement ?",
      body: PublicationEvenementFormView(
        evenement: evenement,
        publierEvenement: publierEvenement,
      ),
    );
  }
}

class PublicationEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function publierEvenement;

  const PublicationEvenementFormView({
    super.key,
    required this.evenement,
    required this.publierEvenement,
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
      widget.publierEvenement();
    });
  }
}
