import 'package:ape_manager_front/models/bouton_radio.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class GroupeBoutonsRadio extends StatefulWidget {
  final List<BoutonRadio> boutonsRadio;
  final int? idBoutonRadioSelectionne;
  final void Function(int?)? onChangedMethod;
  final void Function(int?)? onSavedMethod;

  const GroupeBoutonsRadio({
    super.key,
    required this.boutonsRadio,
    this.idBoutonRadioSelectionne,
    this.onChangedMethod,
    this.onSavedMethod,
  });

  @override
  State<GroupeBoutonsRadio> createState() => _GroupeBoutonsRadioState();
}

class _GroupeBoutonsRadioState extends State<GroupeBoutonsRadio> {
  BoutonRadio? boutonRadioSelectionne;

  @override
  void initState() {
    super.initState();
    boutonRadioSelectionne = widget.idBoutonRadioSelectionne != null
        ? widget.boutonsRadio
            .firstWhere((b) => b.id == widget.idBoutonRadioSelectionne)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (BoutonRadio boutonRadio in widget.boutonsRadio)
          RadioListTile(
            title: Text(
              boutonRadio.libelle,
              style: FontUtils.getFontApp(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            value: boutonRadio.id,
            groupValue: boutonRadioSelectionne?.id,
            onChanged: (value) {
              setState(() {
                boutonRadioSelectionne = boutonRadio;
              });
              if (widget.onChangedMethod != null) {
                widget.onChangedMethod!(value);
              }
            },
          ),
      ],
    );
  }
}
