import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

abstract class Champ extends StatelessWidget {
  // Méthode appelée lors de la sauvegarde du formulaire
  final void Function(String?)? onSavedMethod;

  // Méthode appelée lors de la modification du champ
  final void Function(String?)? onChangedMethod;

  // Libellé affiché pour présenter le champ de saisie
  final String label;

  // Padding vertical à appliquer au champ de saisie
  final double paddingVertical;

  final bool isDense = false;

  final dynamic valeurInitiale;

  final TextEditingController? controller;

  final bool readOnly;

  const Champ({
    super.key,
    required this.label,
    this.onSavedMethod,
    this.onChangedMethod,
    this.paddingVertical = 0.5,
    this.valeurInitiale,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context);

  // Méthode permettant d'afficher un message d'avertissement si aucune action n'a été spécifiée lors du onSaved()
  void Function(String?)? defaultOnSavedMethod(value) {
    print("\x1B[31mLe champ '$label' ne fait rien lors du onSave().\x1B[0m");
    return null;
  }

  void Function(String?)? defaultOnChangedMethod(value) {
    return null;
  }

  TextStyle getTextStyle(BuildContext context) {
    return const TextStyle(height: 1.5, fontSize: 16.0);
  }

  double? getHeight(BuildContext context) {
    return ResponsiveConstraint.getResponsiveValue(context, 70.0, 75.0);
    return null;
  }

  EdgeInsets getPaddingChamp() {
    //return const EdgeInsets.symmetric(vertical: 3.0);
    return const EdgeInsets.symmetric();
  }
}
