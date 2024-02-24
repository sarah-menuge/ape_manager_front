import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../proprietes/couleurs.dart';
import '../utils/font_utils.dart';

class TextTitre extends StatelessWidget {
  final String titre;
  TextTitre({required this.titre});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveConstraint.getResponsiveValue(context,100.0,200.0),
      child: Center(
        child: Text(
          titre,
          textDirection: TextDirection.ltr,
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(context,40.0,60.0),
            color: NOIR,
          ),
        ),
      ),
    );
  }
}