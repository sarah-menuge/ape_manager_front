import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_email.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class DemandeReinitMdpFormView extends StatefulWidget {
  const DemandeReinitMdpFormView({super.key});

  @override
  State<DemandeReinitMdpFormView> createState() =>
      _DemandeReinitMdpFormViewState();
}

class _DemandeReinitMdpFormViewState
    extends FormulaireState<DemandeReinitMdpFormView> {
  String? email;

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampEmail(
            label: "Votre email",
            onSavedMethod: (value) => email = value!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Envoyer",
          fonction: () => appuiBoutonEnvoyer(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonEnvoyer() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaireDemandeReinitMdp();
      });
    }
  }

  Future<void> envoiFormulaireDemandeReinitMdp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final response = await utilisateurProvider.demandeReinitMdp(email);
      if (response["statusCode"] == 200 && mounted) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          erreur = response['message'];
        });
      }
    }
  }
}
