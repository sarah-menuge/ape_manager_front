import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/commandes/details/detail_commande_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupFinaliserCommande extends StatelessWidget {
  final CommandeProvider commandeProvider;
  final Panier panier;

  const PopupFinaliserCommande(
      {super.key, required this.commandeProvider, required this.panier});

  @override
  Widget build(BuildContext context) {
    return Popup(
        titre: "Confirmer la prise de commande",
        sousTitre:
            "Vous vous apprêtez à valider une commande.\nCela vous engage à payer avant la date limite de paiement.",
        body: FinaliserCommandeFormView(
          panier: panier,
          commandeProvider: commandeProvider,
        ));
  }
}

class FinaliserCommandeFormView extends StatefulWidget {
  final CommandeProvider commandeProvider;
  final Panier panier;

  FinaliserCommandeFormView(
      {super.key, required this.panier, required this.commandeProvider});

  @override
  State<FinaliserCommandeFormView> createState() =>
      _FinaliserCommandeFormViewState();
}

class _FinaliserCommandeFormViewState
    extends FormulaireState<FinaliserCommandeFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Valider la commande",
          fonction: () => appuiBoutonFinaliser(),
          themeCouleur: ThemeCouleur.vert,
        ),
      ],
    );
  }

  void appuiBoutonFinaliser() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      FinaliserCommande();
    });
  }

  Future<void> FinaliserCommande() async {
    final response = await widget.commandeProvider
        .creerCommande(utilisateurProvider.token!, widget.panier);
    if (response["statusCode"] != 201 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      naviguerVersPage(
          context,
          CommandeView.routeURL
              .replaceAll(":idCommande", response["idCommande"].toString()));
      afficherMessageSucces(
          context: context,
          message: "Votre commande a bien été prise en compte.",
          duree: 5);
    }
  }
}
