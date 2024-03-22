import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'champ.dart';

class ChampInt extends Champ {
  final Widget? prefixIcon;
  final int incrementValue;
  final void Function(int?)? onChangedMethodInt;
  final void Function(int?)? onSavedMethodInt;
  final bool peutEtreNul;

  const ChampInt({
    super.key,
    required super.label,
    this.prefixIcon,
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    super.valeurInitiale,
    super.controller,
    super.readOnly,
    this.incrementValue = 1,
    this.onChangedMethodInt,
    this.onSavedMethodInt,
    this.peutEtreNul = false,
  }) : assert(incrementValue > 0,
            'La valeur d\'incrémentation doit être positive.');

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        controller ?? TextEditingController(text: valeurInitiale?.toString());
    int val = valeurInitiale ?? 0;

    void _increment() {
      val += incrementValue;
      _controller.text = val.toString();
      onChangedMethodInt?.call(val);
    }

    void _decrement() {
      val -= incrementValue;
      if (val < 0) val = 0;
      _controller.text = val.toString();
      onChangedMethodInt?.call(val);
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
                // initialValue: valeurInitiale?.toString(),
                onSaved: (value) {
                  int? intValue = int.tryParse(value ?? '');
                  if (onSavedMethodInt != null && intValue != null) {
                    onSavedMethodInt!(intValue);
                  }
                },
                validator: (value) {
                  if (peutEtreNul == false &&
                      (value == null || value.isEmpty)) {
                    return 'Veuillez renseigner ce champ.';
                  }
                  if (value != null &&
                      value.isNotEmpty &&
                      int.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide.';
                  }
                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*'))
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
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _increment,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _decrement,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
