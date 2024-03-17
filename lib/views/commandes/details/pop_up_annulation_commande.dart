import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAnnulationCommande extends StatelessWidget {
  final CommandeProvider commandeProvider;
  final int idCommande;
  final Function fetchCommande;

  const PopupAnnulationCommande({
    super.key,
    required this.commandeProvider,
    required this.idCommande,
    required this.fetchCommande,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Annulation d'une commande",
      sousTitre: "Êtes-vous sûr de vouloir annuler votre commande ?",
      body: AnnulationCommandeFormView(
        commandeProvider: commandeProvider,
        idCommande: idCommande,
        fetchCommande: fetchCommande,
      ),
    );
  }
}

class AnnulationCommandeFormView extends StatefulWidget {
  final CommandeProvider commandeProvider;
  final int idCommande;
  final Function fetchCommande;

  const AnnulationCommandeFormView({
    super.key,
    required this.commandeProvider,
    required this.idCommande,
    required this.fetchCommande,
  });

  @override
  State<AnnulationCommandeFormView> createState() =>
      _AnnulationCommandeFormViewState();
}

class _AnnulationCommandeFormViewState
    extends FormulaireState<AnnulationCommandeFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [],
      boutons: [
        BoutonAction(
          text: "Annuler la commande",
          fonction: () => appuiBoutonAnnuler(),
          themeCouleur: ThemeCouleur.rouge,
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonAnnuler() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    final response = await widget.commandeProvider.annulerCommande(
      utilisateurProvider.token!,
      widget.idCommande,
    );
    if (response["statusCode"] == 204 && mounted) {
      afficherMessageSucces(
        context: context,
        message: "La commande a bien été annulée.",
      );
      widget.fetchCommande();
      revenirEnArriere(context);
    } else {
      setState(() {
        erreur = response['message'];
      });
    }
    return;
  }
}
