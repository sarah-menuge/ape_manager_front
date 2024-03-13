import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/organisateur.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/views/evenements/modification/popup_annuler_modifications.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_date.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class ModifierEvenementFormView extends StatefulWidget {
  const ModifierEvenementFormView({super.key});

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
        const [
          ChampString(
            label: "Titre de l'événement",
            prefixIcon: Icon(Icons.title),
          ),
        ],
        const [
          ChampString(
            label: "Description de l'événement",
            prefixIcon: Icon(Icons.description),
          ),
        ],
        [
          ChampDate(
            readOnly: false,
            label: "Début des commandes",
          ),
          ChampDate(
            readOnly: false,
            label: "Fin des commandes",
          ),
          ChampDate(
            readOnly: false,
            label: "Fin de paiement",
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
                fetchEvenements: () {},
                evenement: Evenement(
                  id: -1,
                  titre: '',
                  lieu: '',
                  dateDebut: DateTime.now(),
                  dateFin: DateTime.now(),
                  finPaiement: false,
                  statut: StatutEvenement.BROUILLON,
                  description: '',
                  proprietaire: Organisateur(),
                  organisateurs: [],
                  articles: [],
                  commandes: [],
                ),
              ),
            );
          },
          themeCouleur: ThemeCouleur.rouge,
        ),
        BoutonAction(
          text: "Enregistrer les modifications",
          fonction: () => afficherLogCritical(
            "Enregistrement des modifications non pris en charge",
          ),
          themeCouleur: ThemeCouleur.bleu,
        ),
      ],
    );
  }
}
