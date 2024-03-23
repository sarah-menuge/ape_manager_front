import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'champ.dart';

class ChampInt extends StatefulWidget {
  final String label;
  final Widget? prefixIcon;
  final int? valeurInitiale;
  final int valeurMinimale;
  final int? valeurMaximale;
  final bool readOnly;
  final int incrementValue;
  final void Function(int?)? onChangedMethodInt;
  final void Function(int?)? onSavedMethodInt;
  final bool peutEtreNul;

  const ChampInt({
    super.key,
    required this.label,
    this.prefixIcon,
    required this.valeurInitiale,
    this.valeurMinimale = 0,
    this.valeurMaximale,
    this.readOnly = false,
    this.incrementValue = 1,
    this.onChangedMethodInt,
    this.onSavedMethodInt,
    this.peutEtreNul = false,
  });

  @override
  State<ChampInt> createState() => _ChampIntState();
}

class _ChampIntState extends State<ChampInt> {
  late TextEditingController controller;
  bool afficherBoutonDecrementer = true;
  bool afficherBoutonIncrementer = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.valeurInitiale != null
            ? widget.valeurInitiale.toString()
            : "");
    gererAffichageBoutons(widget.valeurInitiale);
  }

  @override
  Widget build(BuildContext context) {
    return _ChampInt(
      label: widget.label,
      prefixIcon: widget.prefixIcon ?? const Icon(Icons.euro),
      valeurInitiale: widget.valeurInitiale,
      readOnly: widget.readOnly,
      onChangedMethodInt: widget.onChangedMethodInt,
      onSavedMethodInt: widget.onSavedMethodInt,
      controller: controller,
      incrementerValeur: incrementerChamp,
      decrementerValeur: decrementerChamp,
      afficherBoutonIncrementer: afficherBoutonIncrementer,
      afficherBoutonDecrementer: afficherBoutonDecrementer,
      gererAffichageBoutons: gererAffichageBoutons,
      peutEtreNul: widget.peutEtreNul,
    );
  }

  gererAffichageBoutons(int? value) {
    setState(() {
      afficherBoutonDecrementer =
          value != null ? value > widget.valeurMinimale : false;
      afficherBoutonIncrementer = value != null
          ? widget.valeurMaximale == null || value < widget.valeurMaximale!
          : true;
    });
  }

  void setValeur(int value) {
    value <= 0.00
        ? controller.text = 0.toString()
        : controller.text = value.toString();

    if (widget.onChangedMethodInt != null) {
      int? intValue = int.tryParse(controller.text) ?? 0;
      widget.onChangedMethodInt!(intValue);
    }
    gererAffichageBoutons(value);
    setState(() => controller.text);
  }

  void incrementerChamp() {
    int intValue = int.tryParse(controller.text ?? '') ?? 0;
    setValeur(intValue + widget.incrementValue);
  }

  void decrementerChamp() {
    int intValue = int.tryParse(controller.text ?? '') ?? 0;
    setValeur(intValue - widget.incrementValue);
    // setVal(val - incrementValue);
  }
}

class _ChampInt extends Champ {
  final Widget? prefixIcon;
  final void Function(int?)? onChangedMethodInt;
  final void Function(int?)? onSavedMethodInt;
  final Function incrementerValeur;
  final Function decrementerValeur;
  final Function gererAffichageBoutons;
  final bool afficherBoutonIncrementer;
  final bool afficherBoutonDecrementer;
  final bool peutEtreNul;

  const _ChampInt({
    super.key,
    required super.label,
    this.prefixIcon,
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
    this.onChangedMethodInt,
    this.onSavedMethodInt,
    required this.incrementerValeur,
    required this.decrementerValeur,
    required this.gererAffichageBoutons,
    required this.afficherBoutonIncrementer,
    required this.afficherBoutonDecrementer,
    required this.peutEtreNul,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getChamp(context),
            if (!readOnly) ...[
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: afficherBoutonIncrementer
                      ? () => incrementerValeur()
                      : null),
              IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: afficherBoutonDecrementer
                      ? () => decrementerValeur()
                      : null),
            ]
          ],
        ),
      ),
    );
  }

  Widget getChamp(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*$'))],
        onSaved: (value) {
          int? intValue = int.tryParse(value ?? '');
          if (onSavedMethodInt != null) {
            if (intValue != null) {
              onSavedMethodInt!(intValue);
            } else {
              onSavedMethodInt!(null);
            }
          }
        },
        validator: (value) {
          if ((value == null || value.isEmpty) && !peutEtreNul) {
            return 'Veuillez renseigner ce champ.';
          }
          return null;
        },
        onChanged: (value) {
          int? intValue = int.tryParse(value) ?? 0;
          gererAffichageBoutons(intValue);
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
    );
  }
}
