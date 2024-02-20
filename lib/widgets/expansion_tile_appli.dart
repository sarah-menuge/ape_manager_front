// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ExpansionTileAppli extends StatefulWidget {
  final String titre;
  final List<Widget> listeWidget;

  const ExpansionTileAppli({required this.titre, required this.listeWidget});

  @override
  State<ExpansionTileAppli> createState() => _ExpansionTileAppliState();
}

class _ExpansionTileAppliState extends State<ExpansionTileAppli> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 60,
        right: 60,
        top: 40,
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
            letterSpacing: 2,
          ),
        ),
        leading: _isExpanded
            ? Icon(Icons.keyboard_arrow_up, size: 40)
            : Icon(Icons.keyboard_arrow_down, size: 40),
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
    );
  }
}
