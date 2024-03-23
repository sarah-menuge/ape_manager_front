import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'champ.dart';

class ChampDate extends Champ {
  Icon? prefixIcon;
  DateTime? lastSelectedDate;

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
        ) {
    if (valeurInitiale != null && valeurInitiale.isNotEmpty) {
      lastSelectedDate = DateFormat('dd-MM-yyyy').parse(valeurInitiale);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (readOnly) return;
    final DateTime dateDebut = lastSelectedDate == null
        ? DateTime.now()
        : DateTime.now().isBefore(lastSelectedDate!)
            ? DateTime.now()
            : lastSelectedDate!;
    final DateTime anProchain = DateTime(DateTime.now().year + 1, 8, 31);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastSelectedDate ?? dateDebut,
      firstDate: dateDebut,
      lastDate: anProchain,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: BLEU_2),
            ),
          ),
          child: child!,
        );
      },
      helpText: "Date choisie :",
    );
    if (picked != null) {
      lastSelectedDate = picked;
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      if (controller!.text != formattedDate) {
        controller!.text = formattedDate;
        if (onChangedMethod != null) {
          onChangedMethod!(formattedDate);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 0),
      child: TextFormField(
        readOnly: readOnly,
        onSaved: onSavedMethod ?? defaultOnSavedMethod,
        onChanged:
            onChangedMethod != null ? (value) => onChangedMethod!(value) : null,
        controller: controller,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (readOnly) {
            return;
          }
          _selectDate(context);
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          helperText: " ",
          isDense: true,
        ),
      ),
    );
  }
}
