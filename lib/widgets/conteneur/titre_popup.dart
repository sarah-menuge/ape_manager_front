import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class TitrePopup extends StatelessWidget {
  final String titre;

  const TitrePopup({super.key, required this.titre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              ResponsiveConstraint.getResponsiveValue(context, 15.0, 30.0)),
      child: Text(
        titre,
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
          fontSize:
              ResponsiveConstraint.getResponsiveValue(context, 15.0, 16.0),
        ),
      ),
    );
  }
}
