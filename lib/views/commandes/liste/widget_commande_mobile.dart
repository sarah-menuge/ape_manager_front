import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class WidgetCommandeMobile extends StatelessWidget {
  final Commande commande;

  const WidgetCommandeMobile({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getInfosCommandes(context),
            getLibelleEvenementCommande(context),
            getTotauxCommande(context),
          ],
        ),
        getBoutonDetail(),
      ],
    );
  }

  Widget getInfosCommandes(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Commande n°${commande.getNumeroCommande()}",
        textAlign: TextAlign.left,
        style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_1),
      ),
    );
  }

  Widget getLibelleEvenementCommande(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        commande.libelleEvenement,
        textAlign: TextAlign.left,
        style: FontUtils.getFontApp(
          fontSize: POLICE_MOBILE_NORMAL_1,
          fontWeight: FONT_WEIGHT_NORMAL,
        ),
      ),
    );
  }

  Widget getTotauxCommande(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "${commande.getPrixTotal()}€",
        textAlign: TextAlign.left,
        style: FontUtils.getFontApp(
          fontSize: POLICE_MOBILE_NORMAL_1,
          fontWeight: FONT_WEIGHT_NORMAL,
        ),
      ),
    );
  }

  Widget getBoutonDetail() {
    return Align(
      alignment: Alignment.centerRight,
      child: BoutonNavigationGoRouter(
        text: "Plus de détails",
        routeName: "/commandes/${commande.id}",
      ),
    );
  }
}
