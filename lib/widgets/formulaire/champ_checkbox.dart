import 'package:ape_manager_front/widgets/formulaire/champ.dart';
import 'package:flutter/material.dart';

class ChampCheckbox extends Champ {
  final void Function(bool?)? onChangedMethodBool;

  const ChampCheckbox(
      {super.key,
      required super.label,
      super.onSavedMethod,
      super.onChangedMethod,
      super.paddingVertical,
      super.valeurInitiale,
      super.controller,
      super.readOnly,
      this.onChangedMethodBool});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        child: CheckboxListTile(
          title: Text(label),
          value: valeurInitiale,
          onChanged: (bool? value) {
            onChangedMethodBool!(value);
            //print(onChangedMethodBool);
            //onChangedMethodBool ?? boolDefaultOnChangedMethod;
          },
        ),
      ),
    );
  }
}
