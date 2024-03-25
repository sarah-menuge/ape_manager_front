import 'package:ape_manager_front/forms/reinit_mdp_form.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/authentification/login/login_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_mdp.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModificationMdpFormView extends StatefulWidget {
  final String token;

  const ModificationMdpFormView({super.key, required this.token});

  @override
  State<ModificationMdpFormView> createState() =>
      _ModificationMdpFormViewState();
}

class _ModificationMdpFormViewState
    extends FormulaireState<ModificationMdpFormView> {
  late ReinitMdpForm reinitMdpForm = ReinitMdpForm(token: widget.token);

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampMdp(
            label: "Nouveau mot de passe",
            onSavedMethod: (value) => reinitMdpForm.nouveauMdp = value,
            controlerRobustesse: true,
          ),
        ],
        [
          ChampMdp(
            label: "Confirmer mot de passe",
            onSavedMethod: (value) => reinitMdpForm.confirmerNouveauMdp = value,
            controlerRobustesse: false,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: 'Modifier le mot de passe',
          fonction: () => appuiBoutonModifier(),
          themeCouleur: ThemeCouleur.vert,
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonModifier() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (reinitMdpForm.nouveauMdp != reinitMdpForm.confirmerNouveauMdp) {
        setMessageErreur("Les mots de passe sont différents.");
        return;
      }
      appelMethodeAsynchrone(() {
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    final response = await utilisateurProvider.reinitMdp(reinitMdpForm);
    if (response["statusCode"] == 200 && mounted) {
      afficherMessageSucces(
          context: context, message: "Le mot de passe a bien été modifié.");
      revenirEnArriere(context, routeURL: LoginView.routeURL);
    } else {
      afficherLogInfo("La modification du mot de passe a échoué.");
      setState(() {
        erreur = response['message'];
      });
    }
  }
}
