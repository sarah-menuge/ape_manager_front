import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../models/Child.dart';
import '../../proprietes/couleurs.dart';

class TableEnfants extends StatefulWidget {
  @override
  _TableEnfantsState createState() => _TableEnfantsState();
}

class _TableEnfantsState extends State<TableEnfants> {
  GlobalKey _key = GlobalKey();
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
        child: ResponsiveLayout(
          mobileBody: DataTable(
            columnSpacing: 1.0,
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
            ],
            rows: children
                .map((child) => DataRow(
              key: _key,
              onLongPress: () {
                        final RenderBox renderBox = _key.currentContext.findRenderObject();
                        final position = renderBox.localToGlobal(Offset.zero);
                        showMenu(
                          position: RelativeRect.fromLTRB(
                            position.dx,
                            position.dy + renderBox.size.height,
                            position.dx,
                            position.dy,
                          ),
                          context: context,
                          items: [
                            PopupMenuItem(
                              child: TextButton(
                                child: Text('Edit'),
                                onPressed: () {
                                },
                              ),
                            ),
                            PopupMenuItem(
                              child: TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  setState(() {
                                    children.remove(child);
                                  });
                                  Navigator.pop(
                                      context);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      cells: [
                        DataCell(Text(truncateWithEllipsis(child.name, 15))),
                        DataCell(
                            Text(truncateWithEllipsis(child.firstName, 15))),
                        DataCell(Text(child.classe)),
                      ],
                    ))
                .toList(),
          ),
          desktopBody: DataTable(
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
      ),
    );
  }
}