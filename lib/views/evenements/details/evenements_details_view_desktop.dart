import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/Evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/bouton_quantite.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class EvenementsDetailsViewDesktop extends StatelessWidget {
  final Profil profil;
  final Evenement evenement;

  static Article article1 = Article(
    id: 1,
    nom: "Boîte de chocolat mixte",
    quantiteMax: 0,
    prix: 17.99,
    description:
        'Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g, Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g',
    categorie: 'Chocolat',
  );

  static Article article2 = Article(
    id: 2,
    nom: "Boîte de chocolat blanc",
    quantiteMax: 0,
    prix: 10.99,
    description: 'Boîte de chocolat blanc, 250g',
    categorie: 'Chocolat',
  );

  static Article article3 = Article(
    id: 1,
    nom: "Boîte de chocolat noir",
    quantiteMax: 0,
    prix: 25.99,
    description: 'Boîte de chocolat noir, 700g',
    categorie: 'Chocolat',
  );

  static List<Article> liste_articles = [article1, article2, article3];

  const EvenementsDetailsViewDesktop(
      {super.key, required this.profil, required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderAppli(
        titre: "",
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    evenement.titre,
                    textAlign: TextAlign.center,
                    style: FontUtils.getFontApp(fontSize: POLICE_DESKTOP_TITRE),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    evenement.description,
                    textAlign: TextAlign.left,
                    style: FontUtils.getFontApp(
                        fontSize: POLICE_DESKTOP_NORMAL,
                        fontWeight: FONT_WEIGHT_NORMAL),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Étape en cours : ",
                          style: FontUtils.getFontApp(
                            fontSize: POLICE_DESKTOP_NORMAL,
                            fontWeight: FONT_WEIGHT_NORMAL,
                          ),
                        ),
                        TextSpan(
                          text: evenement.statut,
                          style: FontUtils.getFontApp(
                            fontSize: POLICE_DESKTOP_NORMAL,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 0.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: liste_articles.map((article) {
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
                                          fontSize: POLICE_DESKTOP_NORMAL,
                                        ),
                                      ),
                                      TextSpan(
                                        text: article.description,
                                        style: FontUtils.getFontApp(
                                          fontSize: POLICE_DESKTOP_NORMAL,
                                          fontWeight: FONT_WEIGHT_NORMAL,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "${article.prix}€",
                                style: FontUtils.getFontApp(
                                  fontSize: POLICE_DESKTOP_NORMAL,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: QuantiteBouton(),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 0.2),
                      ],
                    );
                  }).toList(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonAppli(
                        text: "Partager l'événement",
                        background: ROUGE,
                        foreground: BLANC,
                        routeName: "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
