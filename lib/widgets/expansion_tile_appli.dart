// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ExpansionTileAppli extends StatefulWidget {
  final String titre;
  final List<Widget> listeWidget;
  final bool expanded;

  const ExpansionTileAppli(
      {required this.titre, required this.listeWidget, this.expanded = true});

  @override
  State<ExpansionTileAppli> createState() => _ExpansionTileAppliState();
}

class _ExpansionTileAppliState extends State<ExpansionTileAppli> {
  late bool _isExpanded;

  @override
  void initState() {
    _isExpanded = widget.expanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: EXPANDED_TILE_WIDTH),
      child: Container(
        margin: EdgeInsets.only(
          left: ResponsiveConstraint.getResponsiveValue(context, 10.0, 60.0),
          right: ResponsiveConstraint.getResponsiveValue(context, 10.0, 60.0),
          top: ResponsiveConstraint.getResponsiveValue(context, 10.0, 40.0),
        ),
        width: MediaQuery.of(context).size.width,
        child: ExpansionTile(
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            widget.titre,
            style: FontUtils.getFontApp(
              fontSize:
                  ResponsiveConstraint.getResponsiveValue(context, 20.0, 30.0),
              letterSpacing: 2,
            ),
          ),
          leading: _isExpanded
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: ResponsiveConstraint.getResponsiveValue(
                      context, 25.0, 40.0),
                )
              : Icon(
                  Icons.keyboard_arrow_right,
                  size: ResponsiveConstraint.getResponsiveValue(
                      context, 25.0, 40.0),
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: CONTOUR_RECTANGLE,
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: CONTOUR_RECTANGLE,
            ),
          ),
          children: widget.listeWidget,
        ),
      ),
    );
  }
}
