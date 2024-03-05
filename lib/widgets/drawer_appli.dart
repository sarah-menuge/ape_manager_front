// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../views/accueil/accueil_view.dart';

class BoutonOnglet {
  final String libelle;
  final String routeName;

  const BoutonOnglet({required this.libelle, required this.routeName});
}

class DrawerAppli extends StatelessWidget {
  const DrawerAppli({super.key});

  static List<BoutonOnglet> boutonsOnglets = [
    BoutonOnglet(
        libelle: "Mes événements", routeName: EvenementsView.routeName),
    BoutonOnglet(libelle: "Mes commandes", routeName: ""),
    BoutonOnglet(libelle: "Mon panier", routeName: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 100, child: DrawerHeaderAppli()),
          ListView.separated(
            shrinkWrap: true,
            itemCount: boutonsOnglets.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 0.2,
            ),
            itemBuilder: (BuildContext context, int index) {
              var boutonOnglet = boutonsOnglets[index];
              return ListTile(
                title: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, boutonOnglet.routeName),
                  child: Text(boutonOnglet.libelle),
                ),
                titleTextStyle: GoogleFonts.oswald(
                  fontSize: 15,
                  color: Colors.black,
                ),
              );
            },
          ),
          Divider(
            thickness: 0.2,
          ),
        ],
      ),
    );
  }
}

class DrawerHeaderAppli extends StatelessWidget {
  const DrawerHeaderAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.all(0),
      child: Row(children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, AccueilView.routeName),
          child: Image(
            image: const AssetImage("assets/images/logoEcole.png"),
            width: 50,
          ),
        ),
        Expanded(
          child: Container(
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
        ),
      ]),
    );
  }
}
