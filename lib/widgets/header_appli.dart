// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/profile/profile_view.dart';
import 'package:ape_manager_front/widgets/logo_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderAppli extends StatelessWidget implements PreferredSizeWidget {
  const HeaderAppli({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Logo de l'application situé à gauche du header pour le Desktop
      leading: MediaQuery.of(context).size.width > 600 ? LogoAppli() : null,
      leadingWidth: MediaQuery.of(context).size.width > 600 ? 300.0 : 50.0,
      // Hauteur du header
      toolbarHeight:
          ResponsiveConstraint.getResponsiveValue(context, 100.0, 200.0),
      // Linéar gradient du header
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [HEADER_FONCE, HEADER_CLAIR]),
        ),
      ),
      // Menu déroulant à droite de l'écran
      actions: [
        Row(
          children: [
            ResponsiveLayout(
              mobileBody: Container(),
              desktopBody: getMenuHeaderDesktop(context),
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
                    onTap: () =>
                        Navigator.pushNamed(context, ProfileView.routeName),
                  ),
                  PopupMenuItem(
                    child: Text("Se déconnecter"),
                    onTap: () {
                      Provider.of<AuthentificationProvider>(context,
                              listen: false)
                          .logout(context);
                    },
                  ),
                ];
              },
              icon: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(HEADER_HEIGHT);

  Widget getMenuHeaderDesktop(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            child: Text(
              "Événements",
              style: FontUtils.getFontApp(fontSize: 15),
            ),
            onTap: () => Navigator.pushNamed(context, EvenementsView.routeName),
          ),
        ),
        SizedBox(height: 25, child: VerticalDivider(color: GRIS_FONCE)),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Mes commandes",
            style: FontUtils.getFontApp(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
