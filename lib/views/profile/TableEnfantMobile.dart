import 'package:flutter/material.dart';

import '../../models/Child.dart';
import '../../proprietes/couleurs.dart';

class TableEnfantsMobile extends StatefulWidget {
  @override
  _TableEnfantsMobileState createState() => _TableEnfantsMobileState();
}

class _TableEnfantsMobileState extends State<TableEnfantsMobile> {
  List<Child> children = [
    Child(
        name: 'Ould-bouktounine-MARCOOOOOOOOOOOOOOOOOOOOOOOOOOOO',
        firstName: 'michel-jaques-pierre-MARCOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO',
        classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'pipou', firstName: 'poupi', classe: 'CE4')
  ];

  Offset? _tapPosition;

  String truncateWithEllipsis(String text, int maxLength) {
    return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
  }

  void _showCustomMenu({required Child child}) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      _tapPosition! & const Size(0, 0),
      Offset.zero & overlay.size,
    );

    showMenu(
      color: BEIGE_FONCE.withOpacity(1.0),
      context: context,
      position: position,
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Modifier', style: TextStyle(color: Colors.black)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const CustomPopupMenuDivider(color: GRIS,),
        PopupMenuItem(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Supprimer', style: TextStyle(color: Colors.black)),
            ),
            onPressed: () {
              setState(() {
                children.remove(child);
              });
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _storePosition,
      child: Container(
        height: 350,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 1.0,
            headingRowColor: MaterialStateProperty.all(BEIGE_FONCE),
            columns: const [
              DataColumn(label: Text('Nom', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Prénom', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Classe', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: children.map((child) {
              return DataRow(
                onLongPress: () {
                  _showCustomMenu(child: child);
                },
                cells: [
                  DataCell(Text(truncateWithEllipsis(child.name, 15))),
                  DataCell(Text(truncateWithEllipsis(child.firstName, 15))),
                  DataCell(Text(child.classe)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
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
