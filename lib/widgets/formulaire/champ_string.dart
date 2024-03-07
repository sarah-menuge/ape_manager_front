import 'package:flutter/material.dart';

import 'champ.dart';

class ChampString extends Champ {
  final Widget? prefixIcon;

  const ChampString({
    super.key,
    required super.label,
    this.prefixIcon,
    super.onSavedMethod,
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
        child: TextFormField(
          readOnly: readOnly,
          onSaved: onSavedMethod ?? defaultOnSavedMethod,
          controller: controller,
          initialValue: valeurInitiale,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez renseigner ce champ.';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: prefixIcon,
            labelStyle: getTextStyle(context),
            contentPadding: getPaddingChamp(),
            helperText: " ",
            isDense: isDense,
          ),
          style: getTextStyle(context),
        ),
      ),
    );
  }
}
