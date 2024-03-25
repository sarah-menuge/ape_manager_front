import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupSuppressionCompte extends StatelessWidget {
  const PopupSuppressionCompte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Popup(
      titre: "Suppression du compte",
      sousTitre: "Êtes-vous sûr de vouloir supprimer votre compte ?",
      body: SuppressionCompteFormView(),
    );
  }
}

class SuppressionCompteFormView extends StatefulWidget {
  const SuppressionCompteFormView({super.key});

  @override
  State<SuppressionCompteFormView> createState() =>
      _SuppressionCompteFormViewState();
}

class _SuppressionCompteFormViewState
    extends FormulaireState<SuppressionCompteFormView> {
  late AuthentificationProvider authentificationProvider;

  @override
  void initState() {
    super.initState();
    authentificationProvider =
        Provider.of<AuthentificationProvider>(context, listen: false);
  }

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [],
      boutons: [
        BoutonAction(
          text: "Supprimer le compte",
          fonction: () => supprimerCompte(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      supprimerCompte();
    });
  }

  Future<void> supprimerCompte() async {
    final response = await utilisateurProvider.supprimerCompte(
      utilisateurProvider.token!,
    );
    if (mounted && response["statusCode"] == 204) {
      afficherMessageInfo(
        context: context,
        message:
            "Le compte associé à l'adresse email ${utilisateurProvider.utilisateur!.email} a bien été supprimé.",
        duree: 6,
      );
      authentificationProvider.logout(
        context,
        utilisateurProvider,
      );
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
