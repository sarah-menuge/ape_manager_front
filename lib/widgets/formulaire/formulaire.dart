import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/formulaire/message_erreur.dart';
import 'package:flutter/material.dart';

class Formulaire extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final EdgeInsetsGeometry paddingFormulaire;
  final double espaceEntreLignes;
  final double espaceEntreColonnes;
  final MainAxisAlignment? alignementBoutons;
  final bool forcerBoutonsEnColonneSurMobile;
  final String? erreur;
  final Widget? contenuManuel;

  // Dimension 2 pour pouvoir afficher plusieurs champs sur une même ligne
  final List<List<dynamic>> champs;

  // Boutons associés au formulaire
  final List<Bouton> boutons;

  Formulaire({
    super.key,
    required this.formKey,
    required this.champs,
    required this.boutons,
    required this.erreur,
    this.paddingFormulaire =
        const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    this.espaceEntreLignes = 0.0,
    this.espaceEntreColonnes = 0.0,
    this.alignementBoutons,
    this.forcerBoutonsEnColonneSurMobile = true,
    this.contenuManuel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingFormulaire,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MessageErreur(erreur: erreur),
            getChamps(context),
            if (contenuManuel != null) contenuManuel!,
            getBoutons(),
          ],
        ),
      ),
    );
  }

  Widget getChamps(BuildContext context) {
    return Container(
      //color: Colors.yellow,
      padding: EdgeInsets.symmetric(
          horizontal:
              ResponsiveConstraint.getResponsiveValue(context, 5.0, 10.0)),
      child: ResponsiveLayout(
        mobileBody: getChampsMobile(),
        desktopBody: getChampsDesktop(),
      ),
    );
  }

  Widget getChampsMobile() {
    return Column(
      children: [
        for (List<dynamic> ligne in champs)
          for (dynamic champ in ligne)
            Container(
              padding: EdgeInsets.symmetric(vertical: espaceEntreLignes),
              child: getChamp(champ),
            ),
      ],
    );
  }

  Widget getChampsDesktop() {
    return Column(
      children: [
        for (List<dynamic> ligne in champs)
          Container(
            padding: EdgeInsets.symmetric(vertical: espaceEntreLignes),
            child: Row(
              children: [
                for (dynamic champ in ligne) Expanded(child: getChamp(champ)),
              ],
            ),
          )
      ],
    );
  }

  Widget getChamp(champ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 + espaceEntreColonnes),
      child: champ,
    );
  }

  Widget getBoutons() {
    if (forcerBoutonsEnColonneSurMobile) {
      return ResponsiveLayout(
        mobileBody: getBoutonsMobile(),
        desktopBody: getBoutonsDesktop(),
      );
    }
    return ResponsiveLayout(
      mobileBody: getBoutonsMobile(),
      desktopBody: getBoutonsDesktop(),
      width: 350,
    );
  }

  Widget getBoutonsMobile() {
    return Column(
      children: boutons.map((bouton) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 0),
          child: bouton,
        );
      }).toList(),
    );
  }

  Widget getBoutonsDesktop() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: getMainAxisAlignment(),
        children: boutons
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  MainAxisAlignment getMainAxisAlignment() {
    if (alignementBoutons != null) return alignementBoutons!;
    if (boutons.length == 1) return MainAxisAlignment.center;
    return MainAxisAlignment.spaceEvenly;
  }
}
