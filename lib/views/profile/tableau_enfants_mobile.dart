import 'package:ape_manager_front/utils/utilitaire_texte.dart';
import 'package:flutter/material.dart';

import '../../models/enfant.dart';
import '../../proprietes/couleurs.dart';

class TableauEnfantsMobile extends StatefulWidget {
  Function modifierEnfant;
  Function supprimerEnfant;
  late List<Enfant> enfants;

  TableauEnfantsMobile({
    required this.modifierEnfant,
    required this.supprimerEnfant,
    required this.enfants,
  });

  @override
  _TableauEnfantsMobileState createState() => _TableauEnfantsMobileState(
        modifierEnfant: modifierEnfant,
        supprimerEnfant: supprimerEnfant,
        enfants: enfants,
      );
}

class _TableauEnfantsMobileState extends State<TableauEnfantsMobile> {
  Function modifierEnfant;
  Function supprimerEnfant;
  List<Enfant> enfants;

  Offset? _tapPosition;

  _TableauEnfantsMobileState({
    required this.modifierEnfant,
    required this.supprimerEnfant,
    required this.enfants,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _storePosition,
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            //columnSpacing: 1.0,
            headingRowColor: MaterialStateProperty.all(BEIGE_FONCE),
            columns: const [
              DataColumn(
                  label: Text('Nom',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Prénom',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Classe',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: enfants
                .map(
                  (enfant) => DataRow(
                    onLongPress: () {
                      _showCustomMenu(enfant: enfant);
                    },
                    cells: [
                      DataCell(Text(tronquerTexte(enfant.nom, 15))),
                      DataCell(Text(tronquerTexte(enfant.prenom, 15))),
                      DataCell(
                        Text(enfant.classe),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  PopupMenuItem _getItemPopupModifier(Enfant enfant) {
    return PopupMenuItem(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Modifier', style: TextStyle(color: Colors.black)),
        ),
        onPressed: () => modifierEnfant(enfant),
      ),
    );
  }

  PopupMenuItem _getItemPopupSupprimer(Enfant enfant) {
    return PopupMenuItem(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Supprimer', style: TextStyle(color: Colors.black)),
        ),
        onPressed: () => supprimerEnfant(enfant),
      ),
    );
  }

  void _showCustomMenu({required Enfant enfant}) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      _tapPosition! & const Size(0, 0),
      Offset.zero & overlay.size,
    );

    showMenu(
      color: BEIGE_FONCE.withOpacity(1.0),
      context: context,
      position: position,
      items: <PopupMenuEntry>[
        _getItemPopupModifier(enfant),
        const CustomPopupMenuDivider(
          color: GRIS,
        ),
        _getItemPopupSupprimer(enfant),
      ],
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}

class CustomPopupMenuDivider extends PopupMenuDivider {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const CustomPopupMenuDivider({
    super.height,
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : super();

  @override
  State<CustomPopupMenuDivider> createState() => _CustomPopupMenuDividerState();
}

class _CustomPopupMenuDividerState extends State<CustomPopupMenuDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: widget.height,
      thickness: widget.thickness,
      indent: widget.indent,
      endIndent: widget.endIndent,
      color: widget.color,
    );
  }
}
