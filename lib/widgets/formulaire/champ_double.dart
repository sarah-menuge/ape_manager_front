import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'champ.dart';

class ChampDouble extends Champ {
  final Widget? prefixIcon;
  final double incrementValue;

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
  }) : assert(incrementValue > 0, 'La valeur d\'incrémentation doit être positive.');

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = controller ?? TextEditingController(text: valeurInitiale);

    void _increment() {
      double currentValue = double.tryParse(_controller.text) ?? 0.0;
      currentValue += incrementValue;
      _controller.text = currentValue.toStringAsFixed(2);
      onChangedMethod?.call(currentValue as String?);
    }

    void _decrement() {
      double currentValue = double.tryParse(_controller.text) ?? 0.0;
      currentValue -= incrementValue;
      if (currentValue < 0) {
        currentValue = 0;
      }
      _controller.text = currentValue.toStringAsFixed(2);
      onChangedMethod?.call(currentValue as String?);
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
                readOnly: readOnly,
                controller: _controller,
                onSaved: (value) {
                  double? doubleValue = double.tryParse(value ?? '');
                  if (onSavedMethod != null && doubleValue != null) {
                    onSavedMethod!(doubleValue as String?);
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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
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
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _increment,
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decrement,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
