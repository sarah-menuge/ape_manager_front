import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/evenement.dart';
import 'package:ape_manager_front/models/panier.dart';
import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/bouton_quantite.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement.dart';
import 'package:ape_manager_front/widgets/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailEvenementView extends StatefulWidget {
  static String routeName = '/evenements/details';
  final Evenement evenement;

  const DetailEvenementView({super.key, required this.evenement});

  @override
  State<DetailEvenementView> createState() => _DetailEvenementViewState();
}

class _DetailEvenementViewState extends State<DetailEvenementView> {
  Panier panier = Panier();
  late UtilisateurProvider utilisateurProvider;
  late RoleUtilisateur roleUtilisateur;

  final EvenementProvider evenementProvider = EvenementProvider();

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    roleUtilisateur = utilisateurProvider.utilisateur!.role;
    fetchListeArticles();
    fetchListeCommandes();
  }

  Future<void> fetchListeArticles() async {
    await evenementProvider.fetchListeArticles(widget.evenement);
    setState(() {
      widget.evenement;
    });
  }

  Future<void> fetchListeCommandes() async {
    await evenementProvider.fetchListeCommandes(widget.evenement);
    setState(() {
      widget.evenement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: DetailEvenementWidget(
        roleUtilisateur: roleUtilisateur,
        evenement: widget.evenement,
        listeView: getInfosArticles(),
        panier: panier,
      ),
    );
  }

  Widget getInfosArticles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.evenement.articles.map((article) {
        return ResponsiveLayout(
            mobileBody: getInfosArticlesMobile(article),
            desktopBody: getInfosArticlesDesktop(article));
      }).toList(),
    );
  }

  Widget getInfosArticlesMobile(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.nom,
                style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_2),
              ),
              Text(
                article.description,
                style: FontUtils.getFontApp(
                  fontSize: POLICE_MOBILE_NORMAL_2,
                  fontWeight: FONT_WEIGHT_NORMAL,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${article.prix.toStringAsFixed(2)}€",
                    style: FontUtils.getFontApp(
                      fontSize: POLICE_MOBILE_NORMAL_2,
                    ),
                  ),
                  if (roleUtilisateur == RoleUtilisateur.parent)
                    QuantiteBouton(
                      ajouterArticle: ajouterArticle,
                      retirerArticle: retirerArticle,
                      article: article,
                    ),
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget getInfosArticlesDesktop(Article article) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${article.nom}\n",
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                        ),
                      ),
                      TextSpan(
                        text: article.description,
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                          fontWeight: FONT_WEIGHT_NORMAL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${article.prix.toStringAsFixed(2)}€",
                style: FontUtils.getFontApp(
                  fontSize: POLICE_DESKTOP_NORMAL_2,
                ),
              ),
              if (roleUtilisateur == RoleUtilisateur.parent)
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 10),
                  child: QuantiteBouton(
                    ajouterArticle: ajouterArticle,
                    retirerArticle: retirerArticle,
                    article: article,
                  ),
                ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  void ajouterArticle(Article article) {
    setState(() {
      panier.ajouterArticle(article);
    });
  }

  void retirerArticle(Article article) {
    setState(() {
      panier.retirerArticle(article);
    });
  }
}
