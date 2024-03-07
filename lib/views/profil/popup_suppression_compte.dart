import 'package:ape_manager_front/providers/authentification_provider.dart';
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
      intitule:
          'Suppression du compte\nÊtes-vous sûr de vouloir supprimer votre compte ?',
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
          text: "Annuler",
          fonction: () => Navigator.of(context).pop(),
          themeCouleur: ThemeCouleur.gris,
        ),
        BoutonAction(
          text: "Supprimer",
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
    final response = await utilisateurProvider.supprimerCompte();
    if (mounted && response["statusCode"] == 200) {
      authentificationProvider.logout(
        context,
        utilisateurProvider,
      );
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
