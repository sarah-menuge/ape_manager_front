import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:flutter/material.dart';

import 'champ.dart';

class ChampMdp extends Champ {
  final bool controlerRobustesse;

  const ChampMdp({
    super.key,
    super.label = "Mot de passe",
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
    required this.controlerRobustesse,
  });

  String? estMdpRobuste(String mdp) {
    // Vérifie qu'il y a au moins une majuscule
    if (!RegExp(r'^.{8,}$').hasMatch(mdp)) {
      return "Le mot de passe doit contenir au moins 8 caractères.";
    }
    if (!RegExp(r'^(?=.*[A-Z].*).*$').hasMatch(mdp)) {
      return "Le mot de passe doit contenir au moins une majuscule.";
    }
    if (!RegExp(r'^(?=.*[0-9].*).*$').hasMatch(mdp)) {
      return "Le mot de passe doit contenir au moins un chiffre.";
    }
    return null;
  }

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
            if (PROD == "true" && controlerRobustesse == true) {
              String? erreurMdpRobuste = estMdpRobuste(value);
              if (erreurMdpRobuste != null) return erreurMdpRobuste;
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
