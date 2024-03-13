import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupSupprimerArticle extends StatelessWidget {
  final Article article;
  final Function fetchArticles;

  const PopupSupprimerArticle({
    super.key,
    required this.article,
    required this.fetchArticles,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "Suppression d'un article",
      sousTitre: "Êtes-vous sûr de vouloir supprimer l'article ?",
      body: SuppressionArticleFormView(
        article: article,
        fetchArticles: fetchArticles,
      ),
    );
  }
}

class SuppressionArticleFormView extends StatefulWidget {
  final Article article;
  final Function fetchArticles;

  const SuppressionArticleFormView({
    super.key,
    required this.article,
    required this.fetchArticles,
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
      supprimerArticle();
    });
  }

  Future<void> supprimerArticle() async {
    afficherLogCritical("Suppression d'un article non pris en charge");
    return;
    final response = null;
    if (mounted && response["statusCode"] == 200) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchArticles();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
