import 'package:ape_manager_front/forms/signup_form.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/profil/profil_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_email.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_mdp.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_telephone.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupFormView extends StatefulWidget {
  const SignupFormView({super.key});

  @override
  State<SignupFormView> createState() => _SignupFormViewState();
}

class _SignupFormViewState extends FormulaireState<SignupFormView> {
  late SignupForm signupForm = SignupForm();
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
      forcerBoutonsEnColonneSurMobile: false,
      champs: [
        [
          ChampString(
            label: "Nom",
            prefixIcon: const Icon(Icons.person),
            onSavedMethod: (value) => signupForm.nom = value!,
          ),
          ChampString(
            label: "Prénom",
            prefixIcon: const Icon(Icons.person_outline),
            onSavedMethod: (value) => signupForm.prenom = value!,
          ),
        ],
        [
          ChampEmail(
            onSavedMethod: (value) => signupForm.email = value!,
          ),
        ],
        [
          ChampTelephone(
            onSavedMethod: (value) => signupForm.telephone = value!,
          ),
        ],
        [
          ChampMdp(
            onSavedMethod: (value) => signupForm.password = value!,
          ),
          ChampMdp(
            label: "Confirmer le mot de passe",
            onSavedMethod: (value) => signupForm.confirmerPassword = value!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: 'S\'inscrire',
          fonction: () => appuiBoutonSEnregistrer(),
          themeCouleur: ThemeCouleur.rouge,
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonSEnregistrer() {
    if (!chargement && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (signupForm.password != signupForm.confirmerPassword) {
        setMessageErreur("Les mots de passe sont différents.");
        return;
      }
      appelMethodeAsynchrone(() {
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    final response = await authentificationProvider.signup(
      signupForm,
      utilisateurProvider,
    );
    if (response["statusCode"] == 200 && mounted) {
      naviguerVersPage(context, ProfilView.routeURL);
      afficherMessageSucces(
          context: context, message: "Compte créé avec succès.");
    } else {
      setMessageErreur(response['message']);
    }
  }
}
