import 'package:ape_manager_front/models/event.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/details/bouton_quantite.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

class EvenementsDetailsViewMobile extends StatelessWidget {
  final Profil profil;
  final Evenement evenement;

  const EvenementsDetailsViewMobile(
      {super.key, required this.profil, required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderAppli(),
      body: EvenementsDetailsWidget(
        evenement: evenement,
        listeView: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: evenement.liste_articles.map((article) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.nom,
                        style: FontUtils.getFontApp(
                            fontSize: POLICE_MOBILE_NORMAL_2),
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
                            "${article.prix}€",
                            style: FontUtils.getFontApp(
                              fontSize: POLICE_MOBILE_NORMAL_2,
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
      ),
      drawer: const DrawerAppli(),
    );
  }
}
