// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/views/mes_commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/views/profil/profil_view.dart';
import 'package:ape_manager_front/widgets/logo_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderAppli extends StatelessWidget {
  static double _screenWidth = 0.0;
  final UtilisateurProvider utilisateurProvider;
  final Function setPerspective;

  const HeaderAppli({
    super.key,
    required this.utilisateurProvider,
    required this.setPerspective,
  });

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      // Logo de l'application situé à gauche du header pour le Desktop
      leading: MediaQuery.of(context).size.width > 600 ? LogoAppli() : null,
      leadingWidth: MediaQuery.of(context).size.width > 600 ? 300.0 : 50.0,
      // Hauteur du header
      toolbarHeight:
          MediaQuery.of(context).size.width > 600 ? 80 : kToolbarHeight,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ResponsiveLayout(
              mobileBody: Container(),
              desktopBody: getMenuHeaderDesktop(context),
            ),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              offset: ResponsiveConstraint.getResponsiveValue(
                  context, Offset(0, 4), Offset(0, 20)),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context) {
                return [
                  if (utilisateurProvider.estAdmin ||
                      utilisateurProvider.estOrganisateur) ...[
                    PopupMenuItem(
                      child: Text("Mode Parents"),
                      onTap: () => setPerspective(context, Perspective.PARENT),
                    ),
                    PopupMenuItem(
                      child: Text("Mode Organisateur"),
                      onTap: () =>
                          setPerspective(context, Perspective.ORGANIZER),
                    ),
                    if (utilisateurProvider.estAdmin)
                      PopupMenuItem(
                        child: Text("Mode Administrateur"),
                        onTap: () => setPerspective(context, Perspective.ADMIN),
                      ),
                  ],
                  PopupMenuItem(
                    child: Text("Mon profil"),
                    onTap: () => naviguerVersPage(context, ProfilView.routeURL),
                  ),
                  PopupMenuItem(
                    child: Text("Se déconnecter"),
                    onTap: () {
                      setPerspective(context, Perspective.PARENT);
                      Provider.of<AuthentificationProvider>(
                        context,
                        listen: false,
                      ).logout(
                        context,
                        Provider.of<UtilisateurProvider>(
                          context,
                          listen: false,
                        ),
                      );
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

  Widget getMenuHeaderDesktop(BuildContext context) {
    if (utilisateurProvider.perspective == Perspective.PARENT) {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              child: Text(
                "Événements",
                style: FontUtils.getFontApp(fontSize: 15),
              ),
              onTap: () => naviguerVersPage(context, EvenementsView.routeURL),
            ),
          ),
          SizedBox(height: 25, child: VerticalDivider(color: GRIS_FONCE)),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              child: Text(
                "Mes commandes",
                style: FontUtils.getFontApp(fontSize: 15),
              ),
              onTap: () => naviguerVersPage(context, MesCommandesView.routeURL),
            ),
          ),
        ],
      );
    } else if (utilisateurProvider.perspective == Perspective.ORGANIZER) {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              child: Text(
                "Événements",
                style: FontUtils.getFontApp(fontSize: 15),
              ),
              onTap: () => naviguerVersPage(context, EvenementsView.routeURL),
            ),
          ),
        ],
      );
    } else if (utilisateurProvider.perspective == Perspective.ADMIN) {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              child: Text(
                "Gestion des utilisateurs",
                style: FontUtils.getFontApp(fontSize: 15),
              ),
              onTap: () => naviguerVersPage(context, ""),
            ),
          ),
        ],
      );
    }
    return Container();
  }
}
