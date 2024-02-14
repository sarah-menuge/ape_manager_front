// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerGlobal extends StatelessWidget {
  const DrawerGlobal({super.key});

  static const List<String> liens = [
    "Mes événements",
    "Mes commandes",
    "Mon panier"
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeaderGlobal(),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: liens.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 0.2,
            ),
            itemBuilder: (BuildContext context, int index) {
              var lien = liens[index];
              return ListTile(
                title: Text(lien),
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

class DrawerHeaderGlobal extends StatelessWidget {
  const DrawerHeaderGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(0),
      child: Row(children: [
        Image(
          image: const AssetImage("assets/images/logoEcole.png"),
          width: 50,
        ),
        Container(
          padding: EdgeInsets.only(left: 5),
          child: Text.rich(
            TextSpan(
                text: "Association des parents d'élèves \n",
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: "École et collège \nSte Marie Pérenchies",
                    style: GoogleFonts.oswald(
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
