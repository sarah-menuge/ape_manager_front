import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_annuler_modifications.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_date.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModifierEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function annulerModificationsInfosGenerales;
  final Function modifierInfosGenerales;

  const ModifierEvenementFormView({
    super.key,
    required this.evenement,
    required this.annulerModificationsInfosGenerales,
    required this.modifierInfosGenerales,
  });

  @override
  State<ModifierEvenementFormView> createState() =>
      _ModifierEvenementFormViewState();
}

class _ModifierEvenementFormViewState
    extends FormulaireState<ModifierEvenementFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            key: UniqueKey(),
            label: "Titre de l'événement",
            prefixIcon: const Icon(Icons.title),
            valeurInitiale: widget.evenement.titre,
            onChangedMethod: (value) => widget.evenement.titre = value!,
          ),
        ],
        [
          ChampString(
            key: UniqueKey(),
            label: "Description de l'événement",
            prefixIcon: const Icon(Icons.description),
            valeurInitiale: widget.evenement.description,
            onChangedMethod: (value) => widget.evenement.description = value!,
          ),
        ],
        [
          ChampDate(
            key: UniqueKey(),
            readOnly: false,
            label: "Début des commandes",
            valeurInitiale: widget.evenement.getDateDebutString(),
            controller: widget.evenement.dateDebutTEC,
            onChangedMethod: (value) => widget.evenement.dateDebut =
                DateFormat('dd-MM-yyyy').parse(value!),
          ),
          ChampDate(
            key: UniqueKey(),
            readOnly: false,
            label: "Fin des commandes",
            valeurInitiale: widget.evenement.getDateFinString(),
            controller: widget.evenement.dateFinTEC,
            onChangedMethod: (value) => widget.evenement.dateFin =
                DateFormat('dd-MM-yyyy').parse(value!),
          ),
          ChampDate(
            key: UniqueKey(),
            readOnly: false,
            label: "Fin de paiement",
            valeurInitiale: widget.evenement.getDateFinPaiementString(),
            controller: widget.evenement.dateFinPaiementTEC,
            onChangedMethod: (value) => widget.evenement.dateFinPaiement =
                DateFormat('dd-MM-yyyy').parse(value!),
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Annuler les modifications",
          fonction: () {
            showDialog(
              context: context,
              builder: (context) => PopupAnnulerModifications(
                annulerModificationsInfosGenerales:
                    widget.annulerModificationsInfosGenerales,
              ),
            );
          },
          themeCouleur: ThemeCouleur.rouge,
        ),
        BoutonAction(
          text: "Enregistrer les modifications",
          fonction: () => widget.modifierInfosGenerales(widget.evenement),
          themeCouleur: ThemeCouleur.bleu,
        ),
      ],
    );
  }
}
