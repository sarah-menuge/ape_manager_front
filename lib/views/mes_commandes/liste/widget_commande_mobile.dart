import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/mes_commandes/details/commande_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class WidgetCommandeMobile extends StatelessWidget {
  const WidgetCommandeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Commande n° 1234",
                textAlign: TextAlign.left,
                style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_1),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Opération chocolat",
                textAlign: TextAlign.left,
                style: FontUtils.getFontApp(
                  fontSize: POLICE_MOBILE_NORMAL_1,
                  fontWeight: FONT_WEIGHT_NORMAL,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "30,99€",
                textAlign: TextAlign.left,
                style: FontUtils.getFontApp(
                  fontSize: POLICE_MOBILE_NORMAL_1,
                  fontWeight: FONT_WEIGHT_NORMAL,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: BoutonNavigationGoRouter(
            text: "Plus de détails",
            routeName: "/commandes/0",
          ),
        ),
      ],
    );
  }
}
