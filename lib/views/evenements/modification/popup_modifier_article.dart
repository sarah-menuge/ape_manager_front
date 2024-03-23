import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_double.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_int.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupModifierArticle extends StatelessWidget {
  final Function modifierArticle;
  final Article article;

  const PopupModifierArticle({
    super.key,
    required this.modifierArticle,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Modification d'un article",
      sousTitre:
          "Veuillez renseigner les informations concernant l'article à modifier.",
      body: ModifierArticleFormView(
        modifierArticle: modifierArticle,
        article: article,
      ),
    );
  }
}

class ModifierArticleFormView extends StatefulWidget {
  final Function modifierArticle;
  final Article article;

  const ModifierArticleFormView({
    super.key,
    required this.modifierArticle,
    required this.article,
  });

  @override
  State<ModifierArticleFormView> createState() =>
      _ModifierArticleFormViewState();
}

class _ModifierArticleFormViewState
    extends FormulaireState<ModifierArticleFormView> {
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
            valeurInitiale: widget.article.nom,
            onSavedMethod: (value) => widget.article.nom = value!,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.description),
            label: "Description de l'article",
            valeurInitiale: widget.article.description,
            onSavedMethod: (value) => widget.article.description = value!,
          ),
        ],
        [
          ChampDouble(
            prefixIcon: const Icon(Icons.euro),
            label: "Prix",
            valeurInitiale: widget.article.prix,
            onSavedMethodDouble: (value) {
              widget.article.prix = value!;
            },
          ),
        ],
        [
          ChampInt(
            prefixIcon: const Icon(Icons.numbers),
            label: "Quantité maximale autorisée",
            valeurInitiale: widget.article.quantiteMax == -1
                ? null
                : widget.article.quantiteMax,
            onSavedMethodInt: (value) =>
                widget.article.quantiteMax = value ?? -1,
            incrementValue: 1,
            peutEtreNul: true,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Modifier l'article",
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
        widget.modifierArticle(widget.article);
      });
    }
  }
}
