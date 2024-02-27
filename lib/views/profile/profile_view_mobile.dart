// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import '../../proprietes/couleurs.dart';
import '../../widgets/TextTitre.dart';
import 'modification_enfants_form_view.dart';
import 'modification_utilisateur_form_view.dart';

class ProfileViewMobile extends StatefulWidget {
  const ProfileViewMobile({Key? key}) : super(key: key);

  @override
  State<ProfileViewMobile> createState() => _ProfileViewMobileState();
}

class _ProfileViewMobileState extends State<ProfileViewMobile> {
  bool readOnly = true;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: [getOngletInfos(), getOngletEnfants()].elementAt(_selectedIndex),
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

  Widget getOngletInfos() {
    return Scaffold(
      appBar: HeaderAppli(titre: ''),
      body: ListView(
        children: [
          TextTitre(titre: 'Mon Profil'),
          ModificationUtilisateurFormView(),
        ],
      ),
      drawer: DrawerAppli(),
    );
  }

  Widget getOngletEnfants() {
    return Scaffold(
      appBar: HeaderAppli(titre: ''),
      body: ListView(
        children: [
          TextTitre(titre: 'Mes Enfants'),
          ModificationEnfantsFormView(),
        ],
      ),
      drawer: DrawerAppli(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
