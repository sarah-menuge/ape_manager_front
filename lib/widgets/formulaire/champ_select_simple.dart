import 'package:flutter/material.dart';

import 'champ.dart';

class ChampSelectSimple extends Champ {
  final Widget? prefixIcon;
  final List<String> valeursExistantes;

  const ChampSelectSimple({
    super.key,
    required super.label,
    required this.valeursExistantes,
    this.prefixIcon,
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        child: DropdownButtonFormField<String>(
          value: valeurInitiale,
          items: valeursExistantes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: prefixIcon,
            labelStyle: getTextStyle(context),
            contentPadding: getPaddingChamp(),
            helperText: " ",
            isDense: isDense,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez choisir une option.';
            }
            return null;
          },
          onSaved: onSavedMethod ?? defaultOnSavedMethod,
          onChanged: onChangedMethod ?? defaultOnChangedMethod,
        ),
      ),
    );
  }
}
