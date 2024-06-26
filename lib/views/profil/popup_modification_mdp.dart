import 'package:ape_manager_front/forms/modification_mdp_form.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_mdp.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../authentification/login/StockageIdentifiants.dart';

class PopupModificationMdp extends StatelessWidget {
  const PopupModificationMdp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Popup(
      titre: 'Modification du mot de passe',
      sousTitre: "Veuillez renseigner les champs suivants.",
      body: ModificationMdpFormView(),
    );
  }
}

class ModificationMdpFormView extends StatefulWidget {
  const ModificationMdpFormView({super.key});

  @override
  State<ModificationMdpFormView> createState() =>
      _ModificationMdpFormViewState();
}

class _ModificationMdpFormViewState
    extends FormulaireState<ModificationMdpFormView> {
  late ModificationMdpForm modifMdpForm;

  @override
  void initState() {
    super.initState();
    modifMdpForm =
        ModificationMdpForm(email: utilisateurProvider.utilisateur!.email);
  }

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampMdp(
            label: "Ancien mot de passe",
            onSavedMethod: (value) => modifMdpForm.oldPassword = value!,
            controlerRobustesse: false,
          ),
        ],
        [
          ChampMdp(
            label: "Nouveau mot de passe",
            onSavedMethod: (value) => modifMdpForm.newPassword = value!,
            controlerRobustesse: true,
          ),
        ],
        [
          ChampMdp(
            label: "Confirmer mot de passe",
            onSavedMethod: (value) =>
                modifMdpForm.confirmerNewPassword = value!,
            controlerRobustesse: false,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: 'Valider la modification',
          fonction: () => appuiBoutonModifier(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonModifier() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      setMessageErreur("");
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaireModificationMdp();
      });
    }
  }

  Future<void> envoiFormulaireModificationMdp() async {
    if (modifMdpForm.newPassword != modifMdpForm.confirmerNewPassword) {
      setMessageErreur("Les deux mots de passe ne correspondent pas.");
      return;
    }

    final response = await utilisateurProvider.modifierMotDePasse(
      utilisateurProvider.token!,
      modifMdpForm,
    );
    if (response["statusCode"] == 200 && mounted) {
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        final StockageIdentifiants _stockageIdentifiants = StockageIdentifiants();
      _stockageIdentifiants.persistIdentifiants(utilisateurProvider.utilisateur!.email, modifMdpForm.newPassword);
      }
      afficherMessageSucces(context: context, message: response["message"]);

      Navigator.of(context).pop();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
