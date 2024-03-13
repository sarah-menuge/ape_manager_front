import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'champ.dart';

class ChampDate extends Champ {
  Icon? prefixIcon;

  ChampDate({
    super.key,
    required super.label,
    this.prefixIcon = const Icon(Icons.calendar_today),
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
    final DateTime maintenant = DateTime.now();
    final DateTime anProchain = DateTime(DateTime.now().year+1,8,31);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maintenant,
      firstDate: maintenant,
      lastDate: anProchain,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: BEIGE_TRES_FONCE,
              onPrimary: Colors.black,
              surface: BLANC_CASSE,
              onSurface: Colors.black,
              
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      helpText: "Date choisie :",

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
