// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/global/drawer_global.dart';
import 'package:ape_manager_front/views/global/header_global.dart';
import 'package:flutter/material.dart';

class AccueilView extends StatelessWidget {
  const AccueilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Accueil',
      ),
      body: Stack(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            child: Image(
              image: AssetImage("assets/images/ecole.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 160,
            child: Center(
              child: Text(
                "Bienvenue sur \n APE Manager",
                textDirection: TextDirection.ltr,
                style: FontUtils.getOswald(),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerGlobal(),
    );
  }
}
