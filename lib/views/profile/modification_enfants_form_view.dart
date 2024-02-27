import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/profile/popup_ajout_enfant.dart';
import 'package:ape_manager_front/views/profile/popup_modification_enfant.dart';
import 'package:ape_manager_front/views/profile/popup_suppression_enfant.dart';
import 'package:ape_manager_front/views/profile/tableau_enfants_desktop.dart';
import 'package:ape_manager_front/views/profile/tableau_enfants_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModificationEnfantsFormView extends StatefulWidget {
  const ModificationEnfantsFormView({super.key});

  @override
  State<ModificationEnfantsFormView> createState() =>
      _ModificationEnfantsFormViewState();
}

class _ModificationEnfantsFormViewState
    extends State<ModificationEnfantsFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? erreur;

  late UtilisateurProvider utilisateurProvider;

  FormState get form => formKey.currentState!;

  late List<Enfant> enfants;

  @override
  void initState() {
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    enfants = Provider.of<UtilisateurProvider>(context, listen: false)
        .utilisateur!
        .enfants;
    return Form(
      key: formKey,
      child: Column(
        children: [
          _getTableauEnfants(),
          const SizedBox(height: 20),
          _getBoutonAjouterEnfant(),
        ],
      ),
    );
  }

  Widget _getTableauEnfants() {
    return ResponsiveLayout(
      width: 1230,
      mobileBody: TableauEnfantsMobile(
        modifierEnfant: _modifierEnfant,
        supprimerEnfant: _supprimerEnfant,
        enfants: enfants,
      ),
      desktopBody: TableauEnfantsDesktop(
        modifierEnfant: _modifierEnfant,
        supprimerEnfant: _supprimerEnfant,
        enfants: enfants,
      ),
    );
  }

  Widget _getBoutonAjouterEnfant() {
    return ElevatedButton(
      onPressed: () => _ajouterEnfant(),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
      child: const Text('Ajouter Enfant'),
    );
  }

  void _ajouterEnfant() {
    showDialog(
      context: context,
      builder: (context) => PopupAjoutEnfant(),
    );
  }

  void _modifierEnfant(Enfant enfant) {
    showDialog(
      context: context,
      builder: (context) => PopupModificationEnfant(),
    );
  }

  void _supprimerEnfant(Enfant enfant) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopupSuppressionEnfant(
        enfant: enfant,
        utilisateurProvider: utilisateurProvider,
      ),
    );
  }
}
