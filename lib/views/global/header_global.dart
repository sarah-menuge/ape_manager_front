// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';

class HeaderGlobal extends StatelessWidget implements PreferredSizeWidget {
  final String titre;

  const HeaderGlobal({required this.titre});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titre),
      centerTitle: true,
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 48),
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
              ),
            ];
          },
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
      ],
      backgroundColor: BEIGE_FONCE,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
