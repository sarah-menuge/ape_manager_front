import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'champ.dart';

class ChampDate extends Champ {
  Icon? prefixIcon = Icon(Icons.calendar_today);

  ChampDate({
    super.key,
    required super.label,
    this.prefixIcon,
    super.onSavedMethod,
    super.onChangedMethod,
    super.paddingVertical,
    String? valeurInitiale,
    TextEditingController? controller,
    super.readOnly,
  }) : super(
    controller: controller ?? TextEditingController(text: valeurInitiale),
    valeurInitiale: null,
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller?.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: TextFormField(
        readOnly: readOnly,
        onSaved: onSavedMethod ?? defaultOnSavedMethod,
        onChanged: onChangedMethod ?? defaultOnChangedMethod,
        controller: controller,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
        validator: (value) {
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
