import 'package:flutter/material.dart';

class BarreNavigationItem {
  String titre;
  String label;
  Icon icon;
  Widget onglet;

  BarreNavigationItem({
    required this.titre,
    required this.label,
    required this.icon,
    required this.onglet,
  });
}
