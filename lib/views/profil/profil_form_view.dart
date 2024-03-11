import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/views/profil/popup_modification_mdp.dart';
import 'package:ape_manager_front/views/profil/popup_suppression_compte.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_email.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_telephone.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class ProfilFormView extends StatefulWidget {
  const ProfilFormView({super.key});

  @override
  State<ProfilFormView> createState() => _ProfilFormViewState();
}

class _ProfilFormViewState extends FormulaireState<ProfilFormView> {
  late Utilisateur utilisateurModifie;
  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    utilisateurModifie = Utilisateur.copie(utilisateurProvider.utilisateur!);
  }

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            label: "Nom",
            prefixIcon: const Icon(Icons.person),
            valeurInitiale: utilisateurModifie.nom,
            readOnly: readOnly,
            onSavedMethod: (value) {
              utilisateurModifie.nom = value!;
            },
          ),
          ChampString(
            label: "Prénom",
            prefixIcon: const Icon(Icons.person_outline),
            valeurInitiale: utilisateurModifie.prenom,
            readOnly: readOnly,
            onSavedMethod: (value) {
              utilisateurModifie.prenom = value!;
            },
          ),
        ],
        [
          ChampEmail(
            valeurInitiale: utilisateurModifie.email,
            readOnly: readOnly,
            onSavedMethod: (value) {
              utilisateurModifie.email = value!;
            },
          ),
          ChampTelephone(
            valeurInitiale: utilisateurModifie.telephone,
            readOnly: readOnly,
            onSavedMethod: (value) {
              utilisateurModifie.telephone = value!;
            },
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: readOnly ? 'Modifier' : 'Sauvegarder',
          fonction: () {
            // Demande pour éditer les infos du profil
            if (readOnly) {
              switchEtatReadonly();
            }
            // Demande pour sauvegarder les modifications des infos du profil
            else {
              appuiBoutonModification();
            }
          },
        ),
        BoutonAction(
          text: readOnly ? 'Supprimer' : 'Annuler',
          fonction: () {
            // Demande de suppression du compte
            if (readOnly) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    const PopupSuppressionCompte(),
              );
            }
            // Demande d'annulation des modifications
            else {
              setState(() {
                utilisateurModifie =
                    Utilisateur.copie(utilisateurProvider.utilisateur!);
                formKey.currentState!.reset();
                switchEtatReadonly();
              });
            }
          },
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
      contenuManuel: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: ROUGE,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const PopupModificationMdp(),
          ),
          child: const Text('Modifier mon mot de passe'),
        ),
      ),
    );
  }

  void switchEtatReadonly() {
    setState(() {
      readOnly = !readOnly;
    });
  }

  void appuiBoutonModification() {
    if (!chargement && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaireModification();
      });
    }
  }

  Future<void> envoiFormulaireModification() async {
    if (utilisateurModifie.equals(utilisateurProvider.utilisateur as Object)) {
      switchEtatReadonly();
      afficherMessageInfo(
          context: context, message: "Aucune modification n'a été détectée.");
      return;
    }
    final response = await utilisateurProvider.modifierInformationsUtilisateur(
      utilisateurProvider.token!,
      utilisateurModifie,
    );
    if (response["statusCode"] == 200 && mounted) {
      switchEtatReadonly();
      utilisateurProvider.updateUser(Utilisateur.copie(utilisateurModifie));
      afficherMessageSucces(context: context, message: response["message"]);
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
