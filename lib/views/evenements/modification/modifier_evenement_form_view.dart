import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/views/evenements/modification/modifier_evenement_view.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_annuler_modifications.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_date.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universal_platform/universal_platform.dart';

class ModifierEvenementFormView extends StatefulWidget {
  final Evenement evenement;
  final Function annulerModificationsInfosGenerales;
  final Function modifierInfosGenerales;
  final DroitEvenement droitEvenement;

  const ModifierEvenementFormView({
    super.key,
    required this.evenement,
    required this.annulerModificationsInfosGenerales,
    required this.modifierInfosGenerales,
    required this.droitEvenement,
  });

  @override
  State<ModifierEvenementFormView> createState() =>
      _ModifierEvenementFormViewState();
}

class _ModifierEvenementFormViewState
    extends FormulaireState<ModifierEvenementFormView> {
  final Key dateDebutChampKey = UniqueKey();
  final Key dateFinChampKey = UniqueKey();
  final Key dateFinPaiementChampKey = UniqueKey();

  @override
  Formulaire setFormulaire(BuildContext context) {
    print("Build setFormulaire : ${widget.evenement.titre}");
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            key: (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)
                ? ValueKey(widget.evenement.titre)
                : UniqueKey(),
            label: "Titre de l'événement",
            prefixIcon: const Icon(Icons.title),
            valeurInitiale: widget.evenement.titre,
            onChangedMethod: (value) => widget.evenement.titre = value!,
            readOnly: widget.droitEvenement != DroitEvenement.modification,
          ),
        ],
        [
          ChampString(
            key: (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)
                ? ValueKey(widget.evenement.description)
                : UniqueKey(),
            label: "Description de l'événement",
            prefixIcon: const Icon(Icons.description),
            valeurInitiale: widget.evenement.description,
            onChangedMethod: (value) => widget.evenement.description = value!,
            readOnly: widget.droitEvenement != DroitEvenement.modification,
          ),
        ],
        [
          ChampDate(
            key: dateDebutChampKey,
            readOnly: widget.droitEvenement != DroitEvenement.modification,
            label: "Début des commandes",
            controller: widget.evenement.dateDebutTEC,
            onChangedMethod: (value) {
              try {
                widget.evenement.dateDebut =
                    DateFormat('dd-MM-yyyy').parse(value!);
              } catch (e) {
                widget.evenement.dateDebut = null;
              }
            },
          ),
          ChampDate(
            key: dateFinChampKey,
            readOnly: widget.droitEvenement != DroitEvenement.modification,
            label: "Fin des commandes",
            controller: widget.evenement.dateFinTEC,
            onChangedMethod: (value) {
              try {
                widget.evenement.dateFin =
                    DateFormat('dd-MM-yyyy').parse(value!);
              } catch (e) {
                widget.evenement.dateFin = null;
              }
            },
          ),
          ChampDate(
            key: dateFinPaiementChampKey,
            readOnly: widget.droitEvenement != DroitEvenement.modification,
            label: "Fin de paiement",
            controller: widget.evenement.dateFinPaiementTEC,
            onChangedMethod: (value) {
              try {
                widget.evenement.dateFinPaiement =
                    DateFormat('dd-MM-yyyy').parse(value!);
              } catch (e) {
                widget.evenement.dateFinPaiement = null;
              }
            },
          ),
        ],
      ],
      boutons: [
        if (widget.droitEvenement == DroitEvenement.modification)
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
        if (widget.droitEvenement == DroitEvenement.modification)
          BoutonAction(
            text: "Enregistrer les modifications",
            fonction: () => widget.modifierInfosGenerales(widget.evenement),
            themeCouleur: ThemeCouleur.bleu,
          ),
      ],
    );
  }
}
