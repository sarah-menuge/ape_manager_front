import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'champ.dart';

class ChampTelephone extends Champ {
  final bool champObligatoire;

  const ChampTelephone({
    super.key,
    super.label = "Téléphone",
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
    this.champObligatoire = false,
  });

  @override
  Widget build(BuildContext context) {
    final RegExp regexTel = RegExp(r'((?=^\+\d{11}$)|(?=^0\d{9}$).*)');
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
          inputFormatters: [
            TextInputFormatter.withFunction(
              (TextEditingValue oldValue, TextEditingValue newValue) {
                // Accepte un numéro de téléphone vide
                if (newValue.text.isEmpty) {
                  return newValue;
                }
                // Numéro de téléphone avec indicatif pays
                if (RegExp(r'((?=^\+\d{0,11}$).*)').hasMatch(newValue.text)) {
                  return newValue;
                }
                // Numéro de téléphone classique : 0 suivi de 9 chiffres
                if (RegExp(r'((?=^0\d{0,9}$).*)').hasMatch(newValue.text)) {
                  return newValue;
                }
                return oldValue;
              },
            ),
          ],
          validator: (value) {
            if (champObligatoire == false && (value == null || value.isEmpty)) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return 'Veuillez renseigner ce champ.';
            }
            if (!regexTel.hasMatch(value)) {
              return 'Veuillez entrer un numéro de téléphone valide.';
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
