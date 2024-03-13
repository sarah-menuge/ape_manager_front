import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_double.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_int.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupAjoutArticle extends StatelessWidget {
  final Function fetchArticles;
  final Article? article;

  PopupAjoutArticle({super.key, required this.fetchArticles, this.article});

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: "${article != null ? 'Modification' : 'Ajout'} d'un article",
      sousTitre:
          "Veuillez renseigner les informations concernant l'article à ${article != null ? 'modifier' : 'ajouter'}.",
      body: AjoutArticleFormView(
        fetchArticles: fetchArticles,
        article: article,
      ),
    );
  }
}

class AjoutArticleFormView extends StatefulWidget {
  final Function fetchArticles;
  Article? article = Article();

  AjoutArticleFormView({
    super.key,
    required this.fetchArticles,
    this.article,
  });

  @override
  State<AjoutArticleFormView> createState() => _AjoutArticleFormViewState();
}

class _AjoutArticleFormViewState extends FormulaireState<AjoutArticleFormView> {
  Article newArticle = Article();

  Article? get article => widget.article ?? Article();

  get evenementProvider => EvenementProvider();
  var isExistingArticle;

  @override
  Formulaire setFormulaire(BuildContext context) {
    isExistingArticle = article?.id != null && article?.id != -1;
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          //nom, prix, quantite,description
          ChampString(
            prefixIcon: const Icon(Icons.abc),
            label: "Nom de l'article",
            onSavedMethod: (value) => newArticle.nom = value!,
            valeurInitiale: isExistingArticle ? article!.nom : null,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.description),
            label: "Description de l'article",
            onSavedMethod: (value) => newArticle.description = value!,
            valeurInitiale: isExistingArticle ? article!.description : null,
          ),
        ],
        [
          ChampDouble(
            prefixIcon: const Icon(Icons.euro),
            label: "Prix",
            onSavedMethod: (value) => newArticle.prix = double.parse(value!),
            valeurInitiale: isExistingArticle ? article!.prix.toString() : null,
          ),
        ],
        [
          ChampInt(
            prefixIcon: const Icon(Icons.numbers),
            label: "Quantité maximale autorisée",
            onSavedMethod: (value) =>
                newArticle.quantiteMax = int.parse(value!),
            valeurInitiale:
                isExistingArticle ? article!.quantiteMax.toString() : null,
            incrementValue: 1,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "${isExistingArticle ? 'Modifier' : 'Ajouter'} l'article",
          fonction: () => appuiBoutonAjouter(),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

  void appuiBoutonAjouter() {
    afficherLogCritical(
        "${isExistingArticle ? 'Modification' : 'Ajout'} d'un article non pris en charge");
    return;
    resetMessageErreur();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        envoiFormulaire();
      });
    }
  }

  Future<void> envoiFormulaire() async {
    final response = await evenementProvider.ajouterArticle(newArticle);
    if (response["statusCode"] == 200 && mounted) {
      afficherMessageSucces(context: context, message: response["message"]);
      Navigator.of(context).pop();
      widget.fetchArticles();
    } else {
      setMessageErreur(response["message"]);
    }
  }
}
