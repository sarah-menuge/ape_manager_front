import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupInfo extends StatelessWidget {
  PopupInfo({super.key, required this.titre, required this.description});
  final String titre;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: this.titre,
      sousTitre: this.description,
      body: InfoEvenement(),
    );
  }
}

class InfoEvenement extends StatefulWidget {
  const InfoEvenement({super.key});

  @override
  State<InfoEvenement> createState() =>
      _InfoEvenementState();
}

class _InfoEvenementState
    extends FormulaireState<InfoEvenement> {

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [],
      boutons: [],
    );
  }
}
