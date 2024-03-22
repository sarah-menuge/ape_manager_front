import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupGestionEvenement extends StatelessWidget {
  final int idEvenement;
  final Function? fonctionAEffectuer;
  final String titrePopup;
  final String sousTitrePopup;
  final String texteBouton;

  const PopupGestionEvenement({
    super.key,
    required this.idEvenement,
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
      body: GestionEvenementFormView(
        idEvenement: idEvenement,
        fonctionAEffectuer: fonctionAEffectuer,
        texteBouton: texteBouton,
      ),
    );
  }
}

class GestionEvenementFormView extends StatefulWidget {
  final int idEvenement;
  final Function? fonctionAEffectuer;
  final String texteBouton;

  const GestionEvenementFormView({
    super.key,
    required this.idEvenement,
    this.fonctionAEffectuer,
    required this.texteBouton,
  });

  @override
  State<GestionEvenementFormView> createState() =>
      _GestionEvenementFormViewState();
}

class _GestionEvenementFormViewState
    extends FormulaireState<GestionEvenementFormView> {
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
        widget.fonctionAEffectuer!(widget.idEvenement);
      });
    }
  }
}
