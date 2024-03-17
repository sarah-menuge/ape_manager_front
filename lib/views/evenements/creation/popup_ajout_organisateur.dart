import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAjoutOrganisateur extends StatelessWidget {
  final List<Organisateur> organisateursSelect;
  final Function ajouterOrganisateur;

  const PopupAjoutOrganisateur({
    super.key,
    required this.organisateursSelect,
    required this.ajouterOrganisateur,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre:
          "Veuillez renseigner les informations concernant l'organisateur à ajouter.",
      body: AjoutOrganisateurFormView(
        organisateursSelect: organisateursSelect,
        ajouterOrganisateur: ajouterOrganisateur,
      ),
    );
  }
}

class AjoutOrganisateurFormView extends StatefulWidget {
  final List<Organisateur> organisateursSelect;
  final Function ajouterOrganisateur;

  const AjoutOrganisateurFormView({
    super.key,
    required this.organisateursSelect,
    required this.ajouterOrganisateur,
  });

  @override
  State<AjoutOrganisateurFormView> createState() =>
      _AjoutOrganisateurFormViewState();
}

class _AjoutOrganisateurFormViewState
    extends FormulaireState<AjoutOrganisateurFormView> {
  Organisateur? newOrganisateur;

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampSelectSimple(
            prefixIcon: const Icon(Icons.person),
            label: "Organisateur",
            onSavedMethod: (value) =>
                newOrganisateur = getOrganisateurByPrenomNom(value),
            valeursExistantes: [
              for (Organisateur orgExistant in widget.organisateursSelect)
                orgExistant.toString(),
            ],
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Ajouter l'organisateur",
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
      if (newOrganisateur == null) return;
      appelMethodeAsynchrone(() {
        widget.ajouterOrganisateur(newOrganisateur);
      });
    }
  }

  Organisateur? getOrganisateurByPrenomNom(String? prenomNom) {
    if (prenomNom == null) return null;
    if (widget.organisateursSelect.isEmpty) return null;
    for (Organisateur org in widget.organisateursSelect) {
      if (org.toString() == prenomNom) return org;
    }
    return null;
  }
}
