// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ape_manager_front/views/global/drawer_global.dart';
import 'package:ape_manager_front/views/global/header_global.dart';
import 'package:flutter/material.dart';

class Evenements extends StatelessWidget {
  const Evenements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderGlobal(
        titre: 'Événements',
      ),
      body: const Center(
        child: Text(
          "Bonsoir",
          textDirection: TextDirection.ltr,
        ),
      ),
      drawer: DrawerGlobal(),
    );
  }
}
