import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/gestion_chargement_formulaire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class FormulaireState<T extends StatefulWidget> extends State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UtilisateurProvider utilisateurProvider;
  String? erreur = " ";
  bool chargement = false;

  bool get desactiverBoutons => chargement;

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestionChargementFormulaire(
      chargement: chargement,
      body: setFormulaire(context),
    );
  }

  Formulaire setFormulaire(BuildContext context);

  Future<void> appelMethodeAsynchrone(Function f) async {
    resetMessageErreur();
    gererChargement(true);
    try {
      f();
    } catch (e) {
      rethrow;
    } finally {
      gererChargement(false);
    }
  }

  void gererChargement(bool chargement) {
    setState(() {
      this.chargement = chargement;
    });
  }

  void setMessageErreur(String message) {
    setState(() {
      erreur = message;
    });
  }

  void resetMessageErreur() {
    setState(() {
      erreur = "";
    });
  }
}
