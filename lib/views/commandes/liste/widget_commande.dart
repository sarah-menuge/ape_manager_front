import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetCommande extends StatelessWidget {
  final Commande commande;

  const WidgetCommande({super.key, required this.commande});

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
    DateFormat formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
    String dateCrea = formatter.format(commande.dateCreation);

    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Commande n°${commande.getNumeroCommande()}",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(fontSize: POLICE_DESKTOP_NORMAL_1),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Effectuée le ${dateCrea}",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontWeight: FONT_WEIGHT_NORMAL,
                fontSize: POLICE_DESKTOP_NORMAL_2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              commande.getStatut(),
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                  fontWeight: FONT_WEIGHT_NORMAL,
                  fontSize: POLICE_DESKTOP_NORMAL_2,
                  color: BLEU_1),
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
              commande.libelleEvenement,
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
              "Montant total : ${commande.getPrixTotal()}€",
              textAlign: TextAlign.left,
              style: FontUtils.getFontApp(
                fontSize: POLICE_DESKTOP_NORMAL_1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Nombre d'articles total : ${commande.nombreArticles}",
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
    return Align(
      alignment: Alignment.centerRight,
      child: BoutonNavigationGoRouter(
        text: "Plus de détails",
        routeName: "/commandes/${commande.id}",
      ),
    );
  }
}
