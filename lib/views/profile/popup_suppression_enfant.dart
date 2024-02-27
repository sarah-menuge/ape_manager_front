import 'package:ape_manager_front/models/enfant.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';

class PopupSuppressionEnfant extends StatefulWidget {
  final UtilisateurProvider utilisateurProvider;
  final Enfant enfant;

  const PopupSuppressionEnfant(
      {super.key, required this.utilisateurProvider, required this.enfant});

  @override
  State<PopupSuppressionEnfant> createState() => _PopupSuppressionEnfantState(
      utilisateurProvider: utilisateurProvider, enfant: enfant);
}

class _PopupSuppressionEnfantState extends State<PopupSuppressionEnfant> {
  final UtilisateurProvider utilisateurProvider;
  Enfant enfant;

  _PopupSuppressionEnfantState(
      {required this.utilisateurProvider, required this.enfant});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BEIGE_CLAIR.withOpacity(1.0),
      title: const Text('Suppression de l\'enfant'),
      content: const Text('Êtes-vous sûr de vouloir supprimer cet enfant ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler', style: TextStyle(color: NOIR)),
        ),
        TextButton(
          onPressed: () => _supprimerEnfant(),
          child: const Text('Supprimer', style: TextStyle(color: ROUGE)),
        ),
      ],
    );
  }

  Future<void> _supprimerEnfant() async {
    final response = await utilisateurProvider.supprimerEnfant(enfant);
    if (mounted && response["statusCode"] == 200) {
      afficherMessageSucces(
          context: context,
          message: "La suppression de l'enfant a été prise en compte.");
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }
}
