import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'champ.dart';

class ChampDouble extends Champ {
  final Widget? prefixIcon;
  final double incrementValue;
  final void Function(double?)? onChangedMethodDouble;
  final void Function(double?)? onSavedMethodDouble;

  const ChampDouble({
    super.key,
    required super.label,
    this.prefixIcon,
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
    this.incrementValue = 0.01,
    this.onChangedMethodDouble,
    this.onSavedMethodDouble,
  }) : assert(incrementValue > 0,
            'La valeur d\'incrémentation doit être positive.');

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = controller ??
        TextEditingController(text: valeurInitiale?.toStringAsFixed(2));

    double val = valeurInitiale ?? 0.0;

    void increment() {
      val += incrementValue;
      _controller.text = val.toStringAsFixed(2);
      onChangedMethodDouble?.call(val);
    }

    void decrement() {
      val -= incrementValue;
      if (val < 0) val = 0;
      _controller.text = val.toStringAsFixed(2);
      onChangedMethodDouble?.call(val);
    }

    return SizedBox(
      height: getHeight(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                readOnly: readOnly,
                // initialValue: valeurInitiale?.toStringAsFixed(2),
                onSaved: (value) {
                  double? doubleValue = double.tryParse(value ?? '');
                  if (onSavedMethodDouble != null && doubleValue != null) {
                    onSavedMethodDouble!(doubleValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez renseigner ce champ.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide.';
                  }
                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d?\d?'))
                ],
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
            if (!readOnly) ...[
              IconButton(icon: const Icon(Icons.add), onPressed: increment),
              IconButton(icon: const Icon(Icons.remove), onPressed: decrement),
            ]
          ],
        ),
      ),
    );
  }
}
