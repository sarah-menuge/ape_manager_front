// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: FOOTER_HEIGHT,
      color: GRIS_FONCE,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () =>
                      launchUrlString('https://www.saintemarieperenchies.fr/'),
                  child: Row(
                    children: [
                      InkWell(
                        child: Image(
                          image: AssetImage("assets/images/logoEcole.png"),
                          width: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                            "Site de l'école / collège \nSainte Marie Pérenchies"),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => launchUrlString('https://www.apel.fr/'),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/APELogo.png"),
                        width: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Site de l'APEL national"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Copyright 2024 - APE Manager",
            style: FontUtils.getFontApp(
              fontSize: 12,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}
