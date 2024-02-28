import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../proprietes/couleurs.dart';
import '../../providers/authentification_provider.dart';
import '../../providers/utilisateur_provider.dart';
import '../../utils/afficher_message.dart';

class PopupSuppressionCompte extends StatefulWidget {
  final UtilisateurProvider utilisateurProvider;

  const PopupSuppressionCompte({super.key, required this.utilisateurProvider});

  @override
  State<PopupSuppressionCompte> createState() =>
      _PopupSuppressionCompteState(utilisateurProvider: utilisateurProvider);
}

class _PopupSuppressionCompteState extends State<PopupSuppressionCompte> {
  final UtilisateurProvider utilisateurProvider;

  _PopupSuppressionCompteState({required this.utilisateurProvider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BEIGE_CLAIR.withOpacity(1.0),
      title: const Text('Suppression du compte'),
      content: const Text('Êtes-vous sûr de vouloir supprimer votre compte ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler', style: TextStyle(color: NOIR)),
        ),
        TextButton(
          onPressed: () => _supprimerCompte(),
          child: const Text('Supprimer', style: TextStyle(color: ROUGE)),
        ),
      ],
    );
  }

  Future<void> _supprimerCompte() async {
    final response = await utilisateurProvider.supprimerCompte();
    if (mounted && response["statusCode"] == 200) {
      Provider.of<AuthentificationProvider>(context, listen: false).logout(
        context,
        Provider.of<UtilisateurProvider>(context, listen: false),
      );
    } else {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }
}
