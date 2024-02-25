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

class EvenementsDetailsViewMobile extends StatelessWidget {
  final Profil profil;
  final Evenement evenement;
  final List<Article> liste_articles;

  const EvenementsDetailsViewMobile(
      {super.key,
      required this.profil,
      required this.evenement,
      required this.liste_articles});

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
                    style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_TITRE),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    evenement.description,
                    textAlign: TextAlign.left,
                    style: FontUtils.getFontApp(
                        fontSize: POLICE_MOBILE_NORMAL,
                        fontWeight: FONT_WEIGHT_NORMAL),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Statut : ",
                          style: FontUtils.getFontApp(
                            fontSize: POLICE_MOBILE_NORMAL,
                            fontWeight: FONT_WEIGHT_NORMAL,
                          ),
                        ),
                        TextSpan(
                          text: evenement.statut,
                          style: FontUtils.getFontApp(
                            fontSize: POLICE_MOBILE_NORMAL,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Aligner le contenu à gauche
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // Aligner le texte à gauche
                            children: [
                              Text(
                                article.nom,
                                style: FontUtils.getFontApp(
                                  fontSize: POLICE_MOBILE_NORMAL,
                                ),
                              ),
                              Text(
                                article.description,
                                style: FontUtils.getFontApp(
                                  fontSize: POLICE_MOBILE_NORMAL,
                                  fontWeight: FONT_WEIGHT_NORMAL,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${article.prix}€",
                                    style: FontUtils.getFontApp(
                                      fontSize: POLICE_MOBILE_NORMAL,
                                    ),
                                  ),
                                  const QuantiteBouton(),
                                ],
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
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
