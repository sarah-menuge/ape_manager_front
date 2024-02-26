// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/profile/change_password.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import '../../widgets/TextTitre.dart';
import 'AllFields.dart';
import 'BoutonAjouterEnfant.dart';
import 'TableEnfants.dart';

class ProfileViewMobile extends StatefulWidget {
  const ProfileViewMobile({Key? key}) : super(key: key);

  @override
  State<ProfileViewMobile> createState() => _ProfileViewMobileState();
}

class _ProfileViewMobileState extends State<ProfileViewMobile> {
  bool readOnly = true;
  int _selectedIndex = 0;

  List<Widget> getWidgetOptions() {
    return <Widget>[
      Scaffold(
        appBar: HeaderAppli(titre: ''),
        body: ListView(
          children: [
            TextTitre(titre: 'Mon Profil'),
            AllFields(readOnly: readOnly),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      readOnly = !readOnly;
                    });
                  },
                  child: Text(readOnly ? 'Modifier' : 'Sauvegarder'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BLEU,
                    foregroundColor: BLANC,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (readOnly) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: BEIGE_FONCE.withOpacity(1.0),
                            title: Text('Suppression du compte'),
                            content: Text(
                                'Êtes-vous sûr de vouloir supprimer votre compte ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Annuler',
                                  style: TextStyle(color: NOIR),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Supprimer',
                                  style: TextStyle(color: ROUGE),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      setState(() {
                        readOnly = !readOnly;
                      });
                    }
                  },
                  child: Text(readOnly ? 'Supprimer' : 'Annuler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ROUGE,
                    foregroundColor: BLANC,
                  ),
                ),
              ],
            ),
            BoutonChangerMDP(),
          ],
        ),
        drawer: DrawerAppli(),
      ),
      Scaffold(
        appBar: HeaderAppli(titre: ''),
        body: ListView(
          children: [
            TextTitre(titre: 'Mes Enfants'),
            TableEnfants(),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: GRIS_FONCE),
                  SizedBox(width: 5),
                  Text("Restez appuyé pour modifier ou supprimer un enfant",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            SizedBox(height: 40),
            Center(child: BoutonAjouterEnfant()),
          ],
        ),
        drawer: DrawerAppli(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = getWidgetOptions();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care),
            label: 'Mes Enfants',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: BEIGE_TRES_FONCE,
        onTap: _onItemTapped,
      ),
    );
  }
}
