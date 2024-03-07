import 'package:flutter/material.dart';

import 'champ.dart';

class ChampEmail extends Champ {
  const ChampEmail({
    super.key,
    super.label = "Email",
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
          initialValue: valeurInitiale,
          controller: controller,
          readOnly: readOnly,
          keyboardType: TextInputType.emailAddress,
          onSaved: onSavedMethod ?? defaultOnSavedMethod,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez renseigner ce champ.';
            } else if (!value.contains("@")) {
              return 'Veuillez renseigner une adresse email valide.';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.email),
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
