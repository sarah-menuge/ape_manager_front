// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/evenements_view.dart';
import 'package:ape_manager_front/widgets/logo_appli.dart';
import 'package:flutter/material.dart';

import '../views/login/login_view.dart';

class HeaderAppli extends StatelessWidget implements PreferredSizeWidget {
  final String titre;

  const HeaderAppli({required this.titre});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: HeaderAppliMobile(
        titre: titre,
      ),
      desktopBody: HeaderAppliDesktop(
        titre: titre,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class HeaderAppliMobile extends StatelessWidget {
  final String titre;

  const HeaderAppliMobile({required this.titre});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [HEADER_FONCE, HEADER_CLAIR]),
        ),
      ),
      title: Text(
        titre,
        style: FontUtils.getFontApp(),
      ),
      centerTitle: true,
      actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          offset: Offset(0, 8),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Mode Parents"),
              ),
              PopupMenuItem(
                child: Text("Mode Organisateurs"),
              ),
              PopupMenuItem(
                child: Text("Mode Administrateur"),
              ),
              PopupMenuItem(
                child: Text("Mon profil"),
              ),
              PopupMenuItem(
                  child: Text("Se déconnecter"),
                  onTap: () =>
                      Navigator.pushNamed(context, LoginView.routeName)),
            ];
          },
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
      ],
    );
  }
}

class HeaderAppliDesktop extends StatelessWidget {
  final String titre;

  const HeaderAppliDesktop({required this.titre});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: LogoAppli(),
      leadingWidth: 300,
      toolbarHeight: 200,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [HEADER_FONCE, HEADER_CLAIR]),
        ),
      ),
      title: Text(
        titre,
        style: FontUtils.getFontApp(),
      ),
      centerTitle: true,
      actions: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: InkWell(
                child: Text(
                  "Événements",
                  style: FontUtils.getFontApp(fontSize: 15),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, EvenementsView.routeName),
              ),
            ),
            VerticalDivider(
              color: GRIS_FONCE,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Mes commandes",
                style: FontUtils.getFontApp(fontSize: 15),
              ),
            ),
            VerticalDivider(
              color: GRIS_FONCE,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 40),
              child: Text(
                "Mon panier",
                style: FontUtils.getFontApp(fontSize: 15),
              ),
            ),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              offset: Offset(0, 15),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Mode Parents"),
                  ),
                  PopupMenuItem(
                    child: Text("Mode Organisateurs"),
                  ),
                  PopupMenuItem(
                    child: Text("Mode Administrateur"),
                  ),
                  PopupMenuItem(
                    child: Text("Mon profil"),
                  ),
                  PopupMenuItem(
                      child: Text("Se déconnecter"),
                      onTap: () =>
                          Navigator.pushNamed(context, LoginView.routeName)),
                ];
              },
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
