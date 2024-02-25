import 'package:ape_manager_front/models/Evenement.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/bouton_quantite.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';

class EvenementsDetailsViewDesktop extends StatelessWidget {
  final Profil profil;
  final Evenement evenement;

  const EvenementsDetailsViewDesktop(
      {super.key, required this.profil, required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderAppli(
        titre: "",
      ),
      body: StickyFooterScrollView(
        footer: const Footer(),
        itemBuilder: (BuildContext context, int index) {
          return EvenementsDetailsWidget(
            evenement: evenement,
            listeView: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: evenement.liste_articles.map((article) {
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
          );
        },
        itemCount: 1,
      ),
    );
  }
}
