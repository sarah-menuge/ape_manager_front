import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/widgets/scaffold/barre_navigation.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/drawer_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/footer_appli.dart';
import 'package:ape_manager_front/widgets/scaffold/header_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';

class ScaffoldAppli extends StatefulWidget {
  final Widget body;
  final List<BarreNavigationItem>? items;
  final String? nomUrlRetour;

  const ScaffoldAppli({
    super.key,
    required this.body,
    this.items,
    this.nomUrlRetour,
  });

  @override
  State<ScaffoldAppli> createState() => _ScaffoldAppliState();
}

class _ScaffoldAppliState extends State<ScaffoldAppli> {
  late UtilisateurProvider utilisateurProvider;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
  }

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
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: HeaderAppli(
          utilisateurProvider: utilisateurProvider,
          setPerspective: setPerspective,
        ),
      ),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamilyFallback: ['Roboto']),
        child: widget.items != null ? getOnglet() : widget.body,
      ),
      drawer: DrawerAppli(
        utilisateurProvider: utilisateurProvider,
      ),
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
          if (widget.nomUrlRetour != null)
            BoutonRetour(nomUrlRetour: widget.nomUrlRetour!),
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
            padding: const EdgeInsets.only(top: 30),
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
        preferredSize: const Size.fromHeight(80),
        child: HeaderAppli(
          utilisateurProvider: utilisateurProvider,
          setPerspective: setPerspective,
        ),
      ),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamilyFallback: ['Roboto']),
        child: StickyFooterScrollView(
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              if (widget.nomUrlRetour != null)
                BoutonRetour(nomUrlRetour: widget.nomUrlRetour!),
              widget.body,
            ]);
          },
          itemCount: 1,
          footer: const Footer(),
        ),
      ),
    );
  }

  void setPerspective(BuildContext context, Perspective p) {
    setState(() {
      utilisateurProvider.setPerspective(p);
    });
    naviguerVersPage(context, AccueilView.routeURL);
  }
}
