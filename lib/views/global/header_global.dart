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
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person,
            size: 40,
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.9, 1.0],
              colors: [BEIGE_FONCE, BEIGE_CLAIR]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
