// ignore_for_file: prefer_const_constructors

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ParentDesktopView extends StatelessWidget {
  const ParentDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "Événements à venir",
              style: FontUtils.getFontApp(
                fontSize: 30,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "Événements en cours",
              style: FontUtils.getFontApp(
                fontSize: 30,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
