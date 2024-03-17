import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/admin/gestion_utilisateurs/image_gestion_utilisateurs.dart';
import 'package:ape_manager_front/views/admin/gestion_utilisateurs/popup_consultation_modification_utilisateur.dart';
import 'package:ape_manager_front/views/admin/gestion_utilisateurs/popup_suppression_utilisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/tableau.dart';
import 'package:ape_manager_front/widgets/conteneur/tuile.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionUtilisateursView extends StatefulWidget {
  static String routeURL = '/gestion-utilisateur';

  const GestionUtilisateursView({super.key});

  @override
  State<GestionUtilisateursView> createState() =>
      _GestionUtilisateursViewState();
}

class _GestionUtilisateursViewState extends State<GestionUtilisateursView> {
  late UtilisateurProvider utilisateurProvider;
  late TextEditingController _searchController;
  List<Utilisateur> utilisateurs = [];
  List<Utilisateur> utilisateursFiltres = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    fetchData();
  }

  Future<void> fetchData() async {
    await utilisateurProvider.fetchUtilisateurs(utilisateurProvider.token!);
    setState(() {
      utilisateurs = utilisateurProvider.utilisateurs;
      utilisateursFiltres = utilisateurs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ImageGestionUtilisateurs(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: getBoutonRechercheUtilisateur(context),
                    ),
                    getTableauUtilisateurs(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBoutonRechercheUtilisateur(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: estDesktop(context, 600)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ChampString(
                      controller: _searchController,
                      label: "",
                      prefixIcon: Icon(Icons.person_search),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: BoutonAction(
                    text: "Rechercher",
                    fonction: filtrerUtilisateurs,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ChampString(
                      controller: _searchController,
                      label: "",
                      prefixIcon: Icon(Icons.person_search),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: BoutonAction(
                    text: "Rechercher",
                    fonction: filtrerUtilisateurs,
                  ),
                ),
              ],
            ),
    );
  }

  void filtrerUtilisateurs() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      utilisateursFiltres = utilisateurs
          .where((utilisateur) =>
              utilisateur.nom
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              utilisateur.prenom
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              utilisateur.email
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              utilisateur
                  .roleToString(utilisateur.role)
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  Widget getTableauUtilisateurs() {
    return Tuile(
      maxHeight: 700,
      maxWidth: 1600,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Tableau(
              tailleTableau: 600,
              modele: Utilisateur(),
              objets: utilisateursFiltres,
              editable: (Utilisateur utilisateur) {
                consulterModifierUtilisateur(context, utilisateur, false);
              },
              supprimable: (Utilisateur utilisateur) {
                supprimerUtilisateur(context, utilisateur);
              },
              consultable: (Utilisateur utilisateur) {
                consulterModifierUtilisateur(context, utilisateur, true);
              },
            ),
          ),
        ],
      ),
    );
  }

  void consulterModifierUtilisateur(
      BuildContext context, Utilisateur utilisateur, bool consultable) {
    showDialog(
      context: context,
      builder: (context) => PopupConsultationModificationUtilisateur(
        utilisateur: utilisateur,
        fetchUtilisateurs: fetchData,
        consultation: consultable,
      ),
    );
  }

  void supprimerUtilisateur(BuildContext context, Utilisateur utilisateur) {
    showDialog(
      context: context,
      builder: (context) => PopupSuppressionUtilisateur(
        utilisateur: utilisateur,
        fetchUtilisateurs: fetchData,
      ),
    );
  }
}
