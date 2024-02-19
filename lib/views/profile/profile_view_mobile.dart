// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/profile/prenom_field.dart';
import 'package:ape_manager_front/views/profile/telephone_field.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import 'email_field.dart';
import 'nom_field.dart';

class ProfileViewMobile extends StatelessWidget {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Profil',
      ),
      body: ListView(
        children: [
          TextProfil(),
          AllFields(),
          SizedBox(height: 40,),
          TableEnfants(),
        ],
      ),
      drawer: DrawerGlobal(),
    );
  }
}

class TextProfil extends StatelessWidget {
  const TextProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 160,
          child: Center(
            child: Text(
              "Mon Profil",
              textDirection: TextDirection.ltr,
              style: FontUtils.getFontApp(
                color: Colors.black,
              ),
            ),
          ),
        );
  }
}

class AllFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: 350,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NomField(),
            SizedBox(
              height: 10,
            ),
            PrenomField(),
            SizedBox(
              height: 10,
            ),
            EmailField(),
            SizedBox(
              height: 10,
            ),
            TelephoneField(),
          ],
        ),
      ),
    );
  }
}


class TableEnfants extends StatefulWidget {
  @override
  _TableEnfantsState createState() => _TableEnfantsState();
}

class _TableEnfantsState extends State<TableEnfants> {
  List<Child> children = [
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
    Child(name: 'Doe', firstName: 'Johnny', classe: 'CP'),
    Child(name: 'pipou', firstName: 'poupi', classe: 'CE4')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 300,
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
            DataCell(Text(child.name)),
            DataCell(Text(child.firstName)),
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

class Child {
  String name;
  String firstName;
  String classe;

  Child({required this.name, required this.firstName, required this.classe});
}