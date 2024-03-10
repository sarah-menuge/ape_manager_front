import 'package:flutter/material.dart';

import 'champ.dart';

class ChampTelephone extends Champ {
  const ChampTelephone({
    super.key,
    super.label = "Téléphone",
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
        child: TextFormField(
          readOnly: readOnly,
          initialValue: valeurInitiale,
          controller: controller,
          keyboardType: TextInputType.phone,
          onSaved: onSavedMethod ?? defaultOnSavedMethod,
          onChanged: onChangedMethod ?? defaultOnChangedMethod,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez renseigner ce champ.';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.phone),
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
