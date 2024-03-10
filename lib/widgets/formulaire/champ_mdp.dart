import 'package:flutter/material.dart';

import 'champ.dart';

class ChampMdp extends Champ {
  const ChampMdp({
    super.key,
    super.label = "Mot de passe",
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
          keyboardType: TextInputType.visiblePassword,
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
            prefixIcon: const Icon(Icons.lock_outline),
            labelStyle: getTextStyle(context),
            contentPadding: getPaddingChamp(),
            helperText: " ",
            isDense: isDense,
          ),
          style: getTextStyle(context),
          obscureText: true,
        ),
      ),
    );
  }
}
