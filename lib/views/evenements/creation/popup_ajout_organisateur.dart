import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAjoutOrganisateur extends StatelessWidget {
  final Function fetchOrganisateurs;
  Organisateur? organisateur = Organisateur();

  PopupAjoutOrganisateur(
      {super.key, required this.fetchOrganisateurs, this.organisateur});

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre:
          "Veuillez renseigner les informations concernant l'organisateur à ${organisateur != null ? 'modifier' : 'ajouter'}.",
      body: AjoutOrganisateurFormView(
        fetchOrganisateurs: fetchOrganisateurs,
        organisateur: organisateur,
      ),
    );
  }
}

class AjoutOrganisateurFormView extends StatefulWidget {
  final Function fetchOrganisateurs;
  Organisateur? organisateur = Organisateur();

  AjoutOrganisateurFormView(
      {super.key, required this.fetchOrganisateurs, this.organisateur});

  @override
  State<AjoutOrganisateurFormView> createState() =>
      _AjoutOrganisateurFormViewState();
}

class _AjoutOrganisateurFormViewState
    extends FormulaireState<AjoutOrganisateurFormView> {
  Organisateur newOrganisateur = Organisateur();

  Organisateur? get organisateur => widget.organisateur ?? Organisateur();

  get evenementProvider => EvenementProvider();

  var isExistingOrganisateur;

  @override
  Formulaire setFormulaire(BuildContext context) {
    isExistingOrganisateur = organisateur?.id != null && organisateur?.id != -1;
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampSelectSimple(
            prefixIcon: const Icon(Icons.person),
            label: "Organisateur",
            onSavedMethod: (value) => newOrganisateur.nom = value!,
            valeurInitiale: isExistingOrganisateur
                ? "${organisateur!.prenom} ${organisateur!.nom}"
                : null,
            valeursExistantes: [
              if (isExistingOrganisateur)
                "${organisateur!.prenom} ${organisateur!.nom}",
              "Florian Dupont",
              "Patricia Martin",
              "Kevin Durand",
              "Emmanuelle Dubois",
              "Jean-luc Moreau",
            ],
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text:
              "${isExistingOrganisateur != null ? 'Modifier' : 'Ajouter'} l'organisateur",
          fonction: () => appuiBoutonAjouter(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonAjouter() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    afficherLogCritical(
        "${isExistingOrganisateur != null ? 'Modification' : 'Ajout'} d'un organisateur non pris en charge");
    return;
    final response =
        await evenementProvider.ajouterOrganisateur(newOrganisateur);
    if (response["statusCode"] == 200 && mounted) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchOrganisateurs();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}