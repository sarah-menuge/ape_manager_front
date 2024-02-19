// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ParentDesktopView extends StatelessWidget {
  const ParentDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 60,
              top: 40,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Événements à venir",
                style: FontUtils.getFontApp(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 60,
              top: 40,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Événements en cours",
                style: FontUtils.getFontApp(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
