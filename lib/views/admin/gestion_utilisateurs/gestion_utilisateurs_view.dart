import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/routage.dart';
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
  late Utilisateur utilisateurCourant;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    utilisateurCourant = utilisateurProvider.utilisateur!;
    fetchData();
  }

  /// Récupère les valeurs des utilisateurs
  Future<void> fetchData() async {
    await utilisateurProvider.fetchUtilisateurs(utilisateurProvider.token!);
    setState(() {
      utilisateurs = utilisateurProvider.utilisateurs
          .where((utilisateur) =>
              (utilisateur.nom != utilisateurCourant.nom) &&
              (utilisateur.prenom != utilisateurCourant.prenom) &&
              (utilisateur.email != utilisateurCourant.email))
          .toList();
      utilisateursFiltres = utilisateurs;
    });
  }

  /// Supprimer un utilisateur depuis la vue administrateur
  Future<void> supprimerUtilisateurAPI(int idUtilisateur) async {
    revenirEnArriere(context);
    final response = await utilisateurProvider.supprimerUtilisateurAdmin(
        utilisateurProvider.token!, idUtilisateur);

    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      Utilisateur? u;
      for (Utilisateur utilisateur in utilisateurProvider.utilisateurs) {
        if (utilisateur.id == idUtilisateur) {
          u = utilisateur;
          break;
        }
      }
      if (u != null) {
        setState(() {
          utilisateurProvider.utilisateurs.remove(u);
        });
      }
      afficherMessageSucces(context: context, message: response["message"]);
    }
  }

  /// Modifier un utilisateur depuis la vue administrateur
  Future<void> modifierUtilisateurAPI(Utilisateur u) async {
    revenirEnArriere(context);
    final response = await utilisateurProvider.modifierUtilisateurAdmin(
        utilisateurProvider.token!, u);

    if (response["statusCode"] != 200 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      afficherMessageSucces(context: context, message: response["message"]);
      for (Utilisateur utilisateur in utilisateurProvider.utilisateurs) {
        if (utilisateur.id == u.id) setState(() => utilisateur = u);
      }
    }
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: getTableauUtilisateurs(),
                    ),
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
      child: estDesktop(context, 642)
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
                Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 400, maxWidth: 500),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ChampString(
                        controller: _searchController,
                        label: "",
                        prefixIcon: Icon(Icons.person_search),
                      ),
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
              nomTableau: "un administrateur",
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
        consultation: consultable,
        fonctionModification: (Utilisateur u) => modifierUtilisateurAPI(u),
      ),
    );
  }

  void supprimerUtilisateur(BuildContext context, Utilisateur utilisateur) {
    showDialog(
      context: context,
      builder: (context) => PopupSuppressionUtilisateur(
        utilisateur: utilisateur,
        fetchUtilisateurs: fetchData,
        fonctionSuppression: supprimerUtilisateurAPI,
      ),
    );
  }
}
