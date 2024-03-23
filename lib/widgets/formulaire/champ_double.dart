import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'champ.dart';

class ChampDouble extends StatefulWidget {
  final String label;
  final Widget? prefixIcon;
  final double valeurInitiale;
  final double valeurMinimale;
  final double? valeurMaximale;
  final bool readOnly;
  final double incrementValue;
  final void Function(double?)? onChangedMethodDouble;
  final void Function(double?)? onSavedMethodDouble;
  final bool peutEtreNul;

  const ChampDouble({
    super.key,
    required this.label,
    this.prefixIcon,
    required this.valeurInitiale,
    this.valeurMinimale = 0,
    this.valeurMaximale,
    this.readOnly = false,
    this.incrementValue = 1,
    this.onChangedMethodDouble,
    this.onSavedMethodDouble,
    this.peutEtreNul = false,
  });

  @override
  State<ChampDouble> createState() => _ChampDoubleState();
}

class _ChampDoubleState extends State<ChampDouble> {
  late TextEditingController controller;
  bool afficherBoutonDecrementer = true;
  bool afficherBoutonIncrementer = true;

  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.valeurInitiale.toStringAsFixed(2));
    gererAffichageBoutons(widget.valeurInitiale);
  }

  @override
  Widget build(BuildContext context) {
    return _ChampDouble(
      label: widget.label,
      prefixIcon: widget.prefixIcon ?? const Icon(Icons.euro),
      valeurInitiale: widget.valeurInitiale,
      readOnly: widget.readOnly,
      onChangedMethodDouble: widget.onChangedMethodDouble,
      onSavedMethodDouble: widget.onSavedMethodDouble,
      controller: controller,
      incrementerValeur: incrementerChamp,
      decrementerValeur: decrementerChamp,
      afficherBoutonIncrementer: afficherBoutonIncrementer,
      afficherBoutonDecrementer: afficherBoutonDecrementer,
      gererAffichageBoutons: gererAffichageBoutons,
      peutEtreNul: widget.peutEtreNul,
    );
  }

  gererAffichageBoutons(double value) {
    setState(() {
      afficherBoutonDecrementer = value > widget.valeurMinimale;
      afficherBoutonIncrementer =
          widget.valeurMaximale == null || value < widget.valeurMaximale!;
    });
  }

  void setValeur(double value) {
    value <= 0.00
        ? controller.text = 0.toStringAsFixed(2)
        : controller.text = value.toStringAsFixed(2);

    if (widget.onChangedMethodDouble != null) {
      double? doubleValue = double.tryParse(controller.text) ?? 0;
      widget.onChangedMethodDouble!(doubleValue);
    }
    gererAffichageBoutons(value);
    setState(() => controller.text);
  }

  void incrementerChamp() {
    double doubleValue = double.tryParse(controller.text ?? '') ?? 0.0;
    setValeur(doubleValue + widget.incrementValue);
  }

  void decrementerChamp() {
    double doubleValue = double.tryParse(controller.text ?? '') ?? 0.0;
    setValeur(doubleValue - widget.incrementValue);
    // setVal(val - incrementValue);
  }
}

class _ChampDouble extends Champ {
  final Widget? prefixIcon;
  final void Function(double?)? onChangedMethodDouble;
  final void Function(double?)? onSavedMethodDouble;
  final Function incrementerValeur;
  final Function decrementerValeur;
  final Function gererAffichageBoutons;
  final bool afficherBoutonIncrementer;
  final bool afficherBoutonDecrementer;
  final bool peutEtreNul;

  const _ChampDouble({
    super.key,
    required super.label,
    this.prefixIcon,
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
    this.onChangedMethodDouble,
    this.onSavedMethodDouble,
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
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d?\d?'))
        ],
        onSaved: (value) {
          double? doubleValue = double.tryParse(value ?? '');
          if (onSavedMethodDouble != null) {
            if (doubleValue != null) {
              onSavedMethodDouble!(doubleValue);
            } else {
              onSavedMethodDouble!(null);
            }
          }
        },
        onChanged: (value) {
          double? doubleValue = double.tryParse(value) ?? 0;
          gererAffichageBoutons(doubleValue);
        },
        validator: (value) {
          if ((value == null || value.isEmpty) && !peutEtreNul) {
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
    );
  }
}
