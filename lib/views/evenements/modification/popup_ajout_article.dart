import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_double.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_int.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAjoutArticle extends StatelessWidget {
  final Function ajouterArticle;

  const PopupAjoutArticle({super.key, required this.ajouterArticle});

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Ajout d'un article",
      sousTitre:
          "Veuillez renseigner les informations concernant l'article à ajouter.",
      body: AjoutArticleFormView(
        ajouterArticle: ajouterArticle,
      ),
    );
  }
}

class AjoutArticleFormView extends StatefulWidget {
  final Function ajouterArticle;

  AjoutArticleFormView({
    super.key,
    required this.ajouterArticle,
  });

  @override
  State<AjoutArticleFormView> createState() => _AjoutArticleFormViewState();
}

class _AjoutArticleFormViewState extends FormulaireState<AjoutArticleFormView> {
  Article newArticle = Article();

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            prefixIcon: const Icon(Icons.abc),
            label: "Nom de l'article",
            onSavedMethod: (value) => newArticle.nom = value!,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.description),
            label: "Description de l'article",
            onSavedMethod: (value) => newArticle.description = value!,
          ),
        ],
        [
          ChampDouble(
            prefixIcon: const Icon(Icons.euro),
            label: "Prix",
            onSavedMethodDouble: (value) => newArticle.prix = value!,
            valeurInitiale: 0,
          ),
        ],
        [
          ChampInt(
            prefixIcon: const Icon(Icons.numbers),
            label: "Quantité maximale autorisée",
            onSavedMethodInt: (value) => newArticle.quantiteMax = value ?? -1,
            incrementValue: 1,
            peutEtreNul: true,
            valeurInitiale: null,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Ajouter l'article",
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
        widget.ajouterArticle(newArticle);
      });
    }
  }
}
