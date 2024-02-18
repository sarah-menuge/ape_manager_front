import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/profile/nom_field.dart';
import 'package:ape_manager_front/views/profile/prenom_field.dart';
import 'package:ape_manager_front/views/profile/telephone_field.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'email_field.dart';

class ProfileViewDesktop extends StatelessWidget {
  const ProfileViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Profil',
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                TextTitre(),
                AllFields(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoutonModifier(),
                    SizedBox(width: 20),
                    BoutonSupprimer()
                  ],
                ),
                TableEnfants(),
                BoutonAjouterEnfant()
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextTitre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Text(
          "Mon Profil",
          textDirection: TextDirection.ltr,
          style: FontUtils.getFontApp(
            fontSize: 60,
            color: NOIR,
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
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NomField(),
                SizedBox(width: 20),
                PrenomField(),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailField(),
                SizedBox(width: 20),
                TelephoneField(),
              ],
            ),
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
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
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
              'Modifier',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'Supprimer',
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

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 80,
      color: GRIS_FONCE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () =>
                launchUrlString('https://www.saintemarieperenchies.fr/'),
            child: Row(
              children: [
                Image(
                  image: AssetImage("assets/images/logoEcole.png"),
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                      "Site de l'école / collège \nSainte Marie Pérenchies"),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => launchUrlString('https://www.apel.fr/'),
            child: Row(
              children: [
                Image(
                  image: AssetImage("assets/images/APELogo.png"),
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Site de l'APEL national"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoutonAjouterEnfant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Ajouter Enfant'),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
    );
  }
}

class BoutonSupprimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Suprimer'),
      style: ElevatedButton.styleFrom(
        backgroundColor: ROUGE,
        foregroundColor: BLANC,
      ),
    );
  }
}

class BoutonModifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Modifier'),
      style: ElevatedButton.styleFrom(
        backgroundColor: BLEU,
        foregroundColor: BLANC,
      ),
    );
  }
}
