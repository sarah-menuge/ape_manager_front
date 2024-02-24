import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/Evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
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
        'Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: ListView(
              children: [
                Text(
                  evenement.titre,
                  textAlign: TextAlign.center,
                  style: FontUtils.getFontApp(
                      fontSize: ResponsiveConstraint.getResponsiveValue(
                          context, 30.0, POLICE_DESKTOP_TITRE),
                      letterSpacing: 2),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    bottom: 20,
                  ),
                  child: Text(
                    evenement.description,
                    textAlign: TextAlign.left,
                    style: FontUtils.getFontApp(
                        fontSize: ResponsiveConstraint.getResponsiveValue(
                            context, 15.0, POLICE_DESKTOP_NORMAL),
                        fontWeight: FontWeight.w200),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Étape en cours : ",
                          style: FontUtils.getFontApp(
                              fontSize: ResponsiveConstraint.getResponsiveValue(
                                  context, 15.0, POLICE_DESKTOP_NORMAL),
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: "${evenement.statut}",
                          style: FontUtils.getFontApp(
                              fontSize: ResponsiveConstraint.getResponsiveValue(
                                  context, 15.0, POLICE_DESKTOP_NORMAL),
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    "Articles en ventes : ",
                    style: FontUtils.getFontApp(
                      fontSize: POLICE_DESKTOP_NORMAL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: liste_articles.map((article) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    article.nom,
                                    style: FontUtils.getFontApp(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${article.prix}€",
                                    style: FontUtils.getFontApp(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 90,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Quantité',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              article.description,
                              style: FontUtils.getFontApp(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            trailing: const Padding(
                              padding: EdgeInsets.only(left: 60),
                              child: Icon(
                                Icons.add_shopping_cart,
                                size: 30.0,
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
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
