import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupGestionCommande extends StatelessWidget {
  final Commande commande;
  final Function? fonctionAEffectuer;
  final String titrePopup;
  final String sousTitrePopup;
  final String texteBouton;

  const PopupGestionCommande({
    super.key,
    required this.commande,
    this.fonctionAEffectuer,
    required this.titrePopup,
    required this.sousTitrePopup,
    required this.texteBouton,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: titrePopup,
      sousTitre: sousTitrePopup,
      body: GestionCommandeFormView(
        commande: commande,
        fonctionAEffectuer: fonctionAEffectuer,
        texteBouton: texteBouton,
      ),
    );
  }
}

class GestionCommandeFormView extends StatefulWidget {
  final Commande commande;
  final Function? fonctionAEffectuer;
  final String texteBouton;

  const GestionCommandeFormView(
      {super.key,
      required this.commande,
      this.fonctionAEffectuer,
      required this.texteBouton});

  @override
  State<GestionCommandeFormView> createState() =>
      _GestionCommandeFormViewState();
}

class _GestionCommandeFormViewState
    extends FormulaireState<GestionCommandeFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: widget.texteBouton,
          fonction: () => appuiBouton(),
          themeCouleur: ThemeCouleur.vert,
        ),
      ],
    );
  }

  void appuiBouton() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        widget.fonctionAEffectuer!(widget.commande.id);
      });
    }
  }
}
