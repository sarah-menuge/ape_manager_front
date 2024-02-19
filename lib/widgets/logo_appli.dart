// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:flutter/material.dart';

class LogoAppli extends StatelessWidget {
  const LogoAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(children: [
        InkWell(
          child: Image(
            image: const AssetImage("assets/images/logoEcole.png"),
            width: 50,
          ),
          onTap: () => Navigator.pushNamed(context, AccueilView.routeName),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text.rich(
            TextSpan(
                text: "Association des parents d'élèves \n",
                style: FontUtils.getFontApp(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: "École et collège \nSte Marie Pérenchies",
                    style: FontUtils.getFontApp(
                      fontWeight: FontWeight.w100,
                      fontSize: 12.5,
                    ),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}
