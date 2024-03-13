import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupModificationEnfant extends StatelessWidget {
  final Function fetchEnfants;
  final Enfant enfant;

  const PopupModificationEnfant(
      {super.key, required this.enfant, required this.fetchEnfants});

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Modification d'un enfant",
      sousTitre:
          "Veuillez renseigner les informations concernant votre enfant.",
      body: ModificationEnfantFormView(
        enfant: enfant,
        fetchEnfants: fetchEnfants,
      ),
    );
  }
}

class ModificationEnfantFormView extends StatefulWidget {
  final Function fetchEnfants;
  final Enfant enfant;

  const ModificationEnfantFormView(
      {super.key, required this.enfant, required this.fetchEnfants});

  @override
  State<ModificationEnfantFormView> createState() =>
      _ModificationEnfantFormViewState();
}

class _ModificationEnfantFormViewState
    extends FormulaireState<ModificationEnfantFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            prefixIcon: const Icon(Icons.person),
            label: "Nom de l'enfant",
            valeurInitiale: widget.enfant.nom,
            onSavedMethod: (value) => widget.enfant.nom = value!,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.person_outline),
            label: "Prénom de l'enfant",
            valeurInitiale: widget.enfant.prenom,
            onSavedMethod: (value) => widget.enfant.prenom = value!,
          ),
        ],
        [
          ChampSelectSimple(
            prefixIcon: const Icon(Icons.school),
            label: "Site de l'enfant",
            valeurInitiale: getSiteSelectionne(widget.enfant.classe),
            onSavedMethod: (value) => widget.enfant.site = value!,
            onChangedMethod: (value) => setState(() {
              widget.enfant.site = value!;
              widget.enfant.classe =
                  getListeClassesDepuisSite(widget.enfant.site)![0];
            }),
            valeursExistantes: Enfant.sitesEtClasses.keys.toList(),
          ),
          ChampSelectSimple(
            valeurInitiale: widget.enfant.classe,
            prefixIcon: const Icon(Icons.school),
            label: "Classe de l'enfant",
            onSavedMethod: (value) => widget.enfant.classe = value!,
            valeursExistantes:
                getListeClassesDepuisClasse(widget.enfant.classe)!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Modifier l'enfant",
          fonction: () => appuiBoutonModifier(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonModifier() {
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    final response = await utilisateurProvider.modifierEnfant(
        utilisateurProvider.token!, widget.enfant);
    if (response["statusCode"] == 200 && mounted) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchEnfants();
    } else {
      setMessageErreur(response["message"]);
    }
  }

  List<String>? getListeClassesDepuisClasse(String classe) {
    String? ecole = getSiteSelectionne(classe);
    if (ecole!.isEmpty) return [];
    return Enfant.sitesEtClasses[ecole]?.toList();
  }

  List<String>? getListeClassesDepuisSite(String site) {
    if (site.isEmpty) return [];
    return Enfant.sitesEtClasses[site]?.toList();
  }

  String? getSiteSelectionne(String classe) {
    for (var entry in Enfant.sitesEtClasses.entries) {
      if (entry.value.contains(classe)) {
        return entry.key;
      }
    }
    return null;
  }
}
