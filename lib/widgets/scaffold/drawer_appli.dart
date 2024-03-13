// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/commandes/liste/mes_commandes_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoutonOnglet {
  final String libelle;
  final String routeName;

  const BoutonOnglet({required this.libelle, required this.routeName});
}

class DrawerAppli extends StatelessWidget {
  final UtilisateurProvider utilisateurProvider;

  const DrawerAppli({
    super.key,
    required this.utilisateurProvider,
  });

  @override
  Widget build(BuildContext context) {
    List<BoutonOnglet> boutonsOnglets = [
      if (utilisateurProvider.perspective == Perspective.PARENT ||
          utilisateurProvider.perspective == Perspective.ORGANIZER)
        BoutonOnglet(libelle: "Événements", routeName: EvenementsView.routeURL),
      if (utilisateurProvider.perspective == Perspective.PARENT)
        BoutonOnglet(
            libelle: "Mes commandes", routeName: MesCommandesView.routeURL),
      if (utilisateurProvider.perspective == Perspective.ADMIN)
        BoutonOnglet(libelle: "Gestion des utilisateurs", routeName: ""),
    ];

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
              return InkWell(
                onTap: () => naviguerVersPage(context, boutonOnglet.routeName),
                child: ListTile(
                  title: Text(boutonOnglet.libelle),
                  titleTextStyle: GoogleFonts.oswald(
                    fontSize: 15,
                    color: Colors.black,
                  ),
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
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: InkWell(
        onTap: () => naviguerVersPage(context, AccueilView.routeURL),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Image(
                image: const AssetImage("assets/images/logoEcole.png"),
                width: 50,
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
            ],
          ),
        ),
      ),
    );
  }
}
