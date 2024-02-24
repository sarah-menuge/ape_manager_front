import 'package:flutter/material.dart';

import '../../models/Child.dart';
import '../../proprietes/couleurs.dart';

class TableEnfantsDesktop extends StatefulWidget {
  @override
  _TableEnfantsDesktopState createState() => _TableEnfantsDesktopState();
}

class _TableEnfantsDesktopState extends State<TableEnfantsDesktop> {
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
  String truncateWithEllipsis(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(BEIGE_FONCE),
          columns: const [
            DataColumn(
                label: Text(
                  'Nom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            DataColumn(
                label: Text(
                  'Prénom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            DataColumn(
                label: Text(
                  'Classe',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            DataColumn(
                label: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            DataColumn(
                label: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
          rows: children
              .map((child) => DataRow(cells: [
            DataCell(Text(truncateWithEllipsis(child.name, 20))),
            DataCell(Text(truncateWithEllipsis(child.firstName, 20))),
            DataCell(Text(child.classe)),
            DataCell(Icon(Icons.edit), onTap: () {}),
            DataCell(Icon(Icons.delete), onTap: () {
              setState(() {
                children.remove(child);
              });
            }),
          ]))
              .toList(),
        ),
      ),
    );
  }
}