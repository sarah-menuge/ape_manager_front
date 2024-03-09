import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class WidgetCommande extends StatelessWidget {
  const WidgetCommande({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getInfosCommandes(context),
          getLibelleEvenementCommande(context),
          getTotauxCommande(context),
          getBoutonDetail(),
        ],
      ),
    );
  }

  Widget getInfosCommandes(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Commande n° 1234",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontSize: POLICE_DESKTOP_NORMAL_1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Commande effectuée le 08 mars 2024",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontWeight: FONT_WEIGHT_NORMAL,
                fontSize: POLICE_DESKTOP_NORMAL_2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLibelleEvenementCommande(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Opération chocolat",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontSize: POLICE_DESKTOP_NORMAL_1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTotauxCommande(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Montant total : 30,99€",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontSize: POLICE_DESKTOP_NORMAL_1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Nombre d'articles total : 3",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontWeight: FONT_WEIGHT_NORMAL,
                fontSize: POLICE_DESKTOP_NORMAL_2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBoutonDetail() {
    return const Align(
      alignment: Alignment.centerRight,
      child: BoutonNavigationGoRouter(
        text: "Plus de détails",
        routeName: "/commandes/0",
      ),
    );
  }
}
