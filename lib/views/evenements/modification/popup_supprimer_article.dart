import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSupprimerArticle extends StatelessWidget {
  final Article article;
  final Function supprimerArticle;

  const PopupSupprimerArticle({
    super.key,
    required this.article,
    required this.supprimerArticle,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un article",
      sousTitre: "Êtes-vous sûr de vouloir supprimer l'article ?",
      body: SuppressionArticleFormView(
        article: article,
        supprimerArticle: supprimerArticle,
      ),
    );
  }
}

class SuppressionArticleFormView extends StatefulWidget {
  final Article article;
  final Function supprimerArticle;

  const SuppressionArticleFormView({
    super.key,
    required this.article,
    required this.supprimerArticle,
  });

  @override
  State<SuppressionArticleFormView> createState() =>
      _SuppressionArticleFormViewState();
}

class _SuppressionArticleFormViewState
    extends FormulaireState<SuppressionArticleFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: const [],
      boutons: [
        BoutonAction(
          text: "Supprimer l'article",
          fonction: () => appuiBoutonSupprimer(),
          themeCouleur: ThemeCouleur.rouge,
        ),
      ],
    );
  }

  void appuiBoutonSupprimer() {
    resetMessageErreur();
    appelMethodeAsynchrone(() {
      widget.supprimerArticle(widget.article);
    });
  }
}
