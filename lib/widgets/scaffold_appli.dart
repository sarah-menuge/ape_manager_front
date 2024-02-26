import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/widgets/drawer_appli.dart';
import 'package:ape_manager_front/widgets/footer_appli.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';

class ScaffoldAppli extends StatelessWidget {
  final Widget body;

  const ScaffoldAppli({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: getScaffoldMobile(),
      desktopBody: getScaffoldDesktop(),
    );
  }

  Widget getScaffoldMobile() {
    return Scaffold(
      appBar: const HeaderAppli(),
      body: body,
      drawer: const DrawerAppli(),
    );
  }

  Widget getScaffoldDesktop() {
    return Scaffold(
      appBar: const HeaderAppli(),
      body: StickyFooterScrollView(
        itemBuilder: (BuildContext context, int index) {
          return body;
        },
        itemCount: 1,
        footer: const Footer(),
      ),
    );
  }
}
