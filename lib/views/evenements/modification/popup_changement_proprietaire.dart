import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupChangementProprietaire extends StatelessWidget {
  final List<Organisateur> organisateursSelect;
  final Function ajouterOrganisateur;

  const PopupChangementProprietaire({
    super.key,
    required this.organisateursSelect,
    required this.ajouterOrganisateur,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Changement du propriétaire de l'événement",
      sousTitre:
      "Veuillez sélectionner le nouvel organisateur de l'événement.",
      body: ChangerProprietaireFormView(
        organisateursSelect: organisateursSelect,
        ajouterOrganisateur: ajouterOrganisateur,
      ),
    );
  }
}

class ChangerProprietaireFormView extends StatefulWidget {
  final List<Organisateur> organisateursSelect;
  final Function ajouterOrganisateur;

  const ChangerProprietaireFormView({
    super.key,
    required this.organisateursSelect,
    required this.ajouterOrganisateur,
  });

  @override
  State<ChangerProprietaireFormView> createState() =>
      _ChangerProprietaireFormViewState();
}

class _ChangerProprietaireFormViewState
    extends FormulaireState<ChangerProprietaireFormView> {
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
          text: "Changer le propriétaire",
          fonction: () => appuiBoutonValider(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonValider() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
          widget.ajouterOrganisateur(newOrganisateur!);
          Navigator.pop(context);
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
