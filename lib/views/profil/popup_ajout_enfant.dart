import 'package:ape_manager_front/models/enfant.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAjoutEnfant extends StatelessWidget {
  final Function fetchEnfants;

  const PopupAjoutEnfant({super.key, required this.fetchEnfants});

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Ajout d'un enfant",
      sousTitre:
          "Veuillez renseigner les informations concernant votre enfant.",
      body: AjoutEnfantFormView(fetchEnfants: fetchEnfants),
    );
  }
}

class AjoutEnfantFormView extends StatefulWidget {
  final Function fetchEnfants;

  const AjoutEnfantFormView({super.key, required this.fetchEnfants});

  @override
  State<AjoutEnfantFormView> createState() => _AjoutEnfantFormViewState();
}

class _AjoutEnfantFormViewState extends FormulaireState<AjoutEnfantFormView> {
  Enfant newEnfant = Enfant();

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
            onSavedMethod: (value) => newEnfant.nom = value!,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.person_outline),
            label: "Prénom de l'enfant",
            onSavedMethod: (value) => newEnfant.prenom = value!,
          ),
        ],
        [
          ChampSelectSimple(
            prefixIcon: const Icon(Icons.school),
            label: "Site de l'enfant",
            onSavedMethod: (value) => newEnfant.site = value!,
            onChangedMethod: (value) => setState(() {
              newEnfant.site = value!;
              newEnfant.classe = getListeClasses(newEnfant.site)![0];
            }),
            valeursExistantes: Enfant.sitesEtClasses.keys.toList(),
          ),
          ChampSelectSimple(
            valeurInitiale: newEnfant.classe,
            prefixIcon: const Icon(Icons.school),
            label: "Classe de l'enfant",
            onSavedMethod: (value) => newEnfant.classe = value!,
            valeursExistantes: getListeClasses(newEnfant.site)!,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Ajouter l'enfant",
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
    final response = await utilisateurProvider.ajouterEnfant(
        utilisateurProvider.token!, newEnfant);
    if (response["statusCode"] == 201 && mounted) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchEnfants();
    } else {
      setMessageErreur(response["message"]);
    }
  }

  List<String>? getListeClasses(String ecole) {
    if (ecole.isEmpty) return [];
    return Enfant.sitesEtClasses[ecole]?.toList();
  }
}
