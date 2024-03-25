import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/commandes/retrait/image_gestion_commandes.dart';
import 'package:ape_manager_front/views/commandes/retrait/popup_consultation_modification_commande.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/tableau.dart';
import 'package:ape_manager_front/widgets/conteneur/tuile.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../providers/utilisateur_provider.dart';
import '../../../utils/afficher_message.dart';
import '../../../utils/routage.dart';
import 'scanneurQrCode.dart';

class RetraitCommandeView extends StatefulWidget {
  static String routeURL = '/retrait_commandes';

  const RetraitCommandeView({super.key});

  @override
  State<RetraitCommandeView> createState() => _RetraitCommandeViewState();
}

class _RetraitCommandeViewState extends State<RetraitCommandeView> {
  late CommandeProvider commandeProvider;
  late UtilisateurProvider utilisateurProvider;
  late TextEditingController _searchController;
  List<Commande> commandes = [];
  List<Commande> commandesFiltres = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    commandeProvider = Provider.of<CommandeProvider>(context, listen: false);
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    fetchData();
  }

  Future<void> fetchData() async {
    await commandeProvider.fetchAllCommandes(utilisateurProvider.token!);
    setState(() {
      commandes = commandeProvider.commandes;
      commandesFiltres = commandes
          .where((commande) => commande.statut == StatutCommande.A_RETIRER)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ImageGestionCommandes(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: getBoutonRechercheCommande(context),
                    ),
                    getTableauCommandes(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBoutonRechercheCommande(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: estDesktop(context, 600)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ChampString(
                      controller: _searchController,
                      label: "",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: BoutonAction(
                    text: "Rechercher",
                    fonction: filtrerCommandes,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoutonAction(
                        text: "Rechercher",
                        fonction: filtrerCommandes,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (UniversalPlatform.isIOS ||
                          UniversalPlatform.isAndroid)
                        BoutonAction(
                          text: "Scanner QR Code",
                          fonction: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ScanneurQrCode(
                                  actionScan: (String code) {
                                    String numeroCommande =
                                        code.split('/').last;
                                    numeroCommande =
                                        numeroCommande.padLeft(5, '0');
                                    Commande commande = commandes.firstWhere(
                                        (commande) =>
                                            commande
                                                .getNumeroCommande()
                                                .toString() ==
                                            numeroCommande);
                                    consulterModifierCommande(
                                        context, commande, true);
                                  },
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  void filtrerCommandes() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      commandesFiltres = commandes
          .where((commande) =>
              commande.libelleEvenement
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              commande.nomUtilisateur
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              commande
                  .getNumeroCommande()
                  .toString()
                  .contains(searchText.toLowerCase()) ||
              commande.lieuRetrait
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
      commandesFiltres = commandesFiltres
          .where((commande) => commande.statut == StatutCommande.A_RETIRER)
          .toList();
      print(commandesFiltres);
    });
  }

  Widget getTableauCommandes() {
    return Tuile(
      maxHeight: 700,
      maxWidth: 1600,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Tableau(
              tailleTableau: 600,
              modele: Commande(),
              objets: commandesFiltres,
              consultable: (Commande commande) {
                consulterModifierCommande(context, commande, true);
              },
            ),
          ),
        ],
      ),
    );
  }

  void consulterModifierCommande(
      BuildContext context, Commande commande, bool consultable) {
    showDialog(
      context: context,
      builder: (context) => PopupConsultationModificationCommande(
        commande: commande,
        fetchCommandes: fetchData,
        retirerCommande: validerRetrait,
        consultation: consultable,
      ),
    );
  }

  Future<void> validerRetrait(int idCommande) async {
    final response = await commandeProvider.passerCommandeRetiree(
        utilisateurProvider.token!, idCommande);
    if (response["statusCode"] != 204 && mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    } else {
      revenirEnArriere(context);
      for (Commande commande in commandes) {
        if (commande.id == idCommande) {
          setState(() {
            commande.statut = StatutCommande.CLOTUREE;
          });
          afficherMessageSucces(
              context: context,
              message:
                  "La commande n°${commande.getNumeroCommande()} a été retirée.",
              duree: 5);
        }
        setState(() {
          commandes.firstWhere((cmd) => cmd.id == idCommande).statut =
              StatutCommande.CLOTUREE;
          commandesFiltres = commandes
              .where((cmd) => cmd.statut == StatutCommande.A_RETIRER)
              .toList();
        });
        await fetchData();
      }
    }
  }
}
