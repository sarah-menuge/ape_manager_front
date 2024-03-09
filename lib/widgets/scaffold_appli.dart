import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/barre_navigation.dart';
import 'package:flutter/material.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';

class ScaffoldAppli extends StatefulWidget {
  final Widget body;
  final List<BarreNavigationItem>? items;

  const ScaffoldAppli({
    super.key,
    required this.body,
    this.items,
  });

  @override
  State<ScaffoldAppli> createState() => _ScaffoldAppliState();
}

class _ScaffoldAppliState extends State<ScaffoldAppli> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: getScaffoldMobile(),
      desktopBody: getScaffoldDesktop(),
    );
  }

  Widget getScaffoldMobile() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HeaderAppli(),
      ),
      body: widget.items != null ? getOnglet() : widget.body,
      drawer: const DrawerAppli(),
      bottomNavigationBar: widget.items != null
          ? BodyNavigationBar(
              items: widget.items,
              currentIndex: _selectedIndex,
              onTabTapped: _onItemTapped)
          : null,
    );
  }

  Widget getOnglet() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                widget.items![_selectedIndex].titre,
                textAlign: TextAlign.center,
                style: FontUtils.getFontApp(
                    fontSize: ResponsiveConstraint.getResponsiveValue(
                        context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: widget.items![_selectedIndex].onglet,
            ),
          ),
        ],
      ),
    );
  }

  Widget getScaffoldDesktop() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: HeaderAppli(),
      ),
      body: StickyFooterScrollView(
        itemBuilder: (BuildContext context, int index) {
          return widget.body;
        },
        itemCount: 1,
        footer: const Footer(),
      ),
    );
  }
}
