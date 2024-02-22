// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/profile/change_password.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';

import '../../proprietes/couleurs.dart';
import '../../widgets/TextTitre.dart';
import 'AllFields.dart';
import 'BoutonAjouterEnfant.dart';
import 'BoutonModifier.dart';
import 'BoutonSupprimer.dart';
import 'TableEnfants.dart';

class ProfileViewMobile extends StatelessWidget {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar();
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    //Moi
    Scaffold(
      appBar: HeaderAppli(
        titre: 'Profil',
      ),
      body: ListView(
        children: [
        TextTitre(titre: 'Mon Profil',),
          AllFields(),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children :[
          BoutonModifier(),
          BoutonSupprimer(),],),
          BoutonChangerMDP(),
        ],
      ),
      drawer: DrawerAppli(),
    ),
    //Mes Enfants
    Scaffold(
      appBar: HeaderAppli(
        titre: 'Profil',
      ),
      body: ListView(
        children: [
          TextTitre(titre: 'Mes Enfants',),
          TableEnfants(),
          SizedBox(height: 40,),
          Center(child : BoutonAjouterEnfant()),
        ],
      ),
      drawer: DrawerAppli(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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



