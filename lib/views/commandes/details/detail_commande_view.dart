import 'dart:convert';

import 'package:ape_manager_front/export/export_pdf.dart';
import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/commande_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/views/commandes/details/pop_up_annulation_commande.dart';
import 'package:ape_manager_front/views/commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/scaffold/scaffold_appli.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class CommandeView extends StatefulWidget {
  static String routeURL = '/commandes/:idCommande';
  final int idCommande;

  const CommandeView({super.key, required this.idCommande});

  @override
  State<CommandeView> createState() => _CommandeViewState();
}

class _CommandeViewState extends State<CommandeView> {
  late UtilisateurProvider utilisateurProvider;
  late CommandeProvider commandeProvider;

  Commande? commande = null;

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    commandeProvider = Provider.of<CommandeProvider>(context, listen: false);
    fetchCommande();
  }

  Future<void> fetchCommande() async {
    await commandeProvider.fetchCommandes(utilisateurProvider.token!);
    setState(() {
      commande = commandeProvider.getCommande(widget.idCommande);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppli(
      nomUrlRetour: MesCommandesView.routeURL,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: PAGE_WIDTH),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: ResponsiveConstraint.getResponsiveValue(
                      context, 20.0, 0.0),
                ),
                child: getCommande(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCommande(BuildContext context) {
    if (commande == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getNumeroCommande(context),
        getLibelleEvenement(context),
        getStatutCommande(context),
        const Divider(thickness: 0.5),
        ...commande!.listeLigneCommandes.map((ligneCommande) {
          return getInfosArticles(context, ligneCommande);
        }),
        getPrixTotal(context),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: getBoutons(context),
        ),
      ],
    );
  }

  Widget getNumeroCommande(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Commande n°${commande!.getNumeroCommande()}",
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_H1, POLICE_DESKTOP_H1)),
      ),
    );
  }

  Widget getLibelleEvenement(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        commande!.libelleEvenement,
        textAlign: TextAlign.center,
        style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_H2, POLICE_DESKTOP_H2)),
      ),
    );
  }

  Widget getStatutCommande(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Statut : ",
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                fontWeight: FONT_WEIGHT_NORMAL,
              ),
            ),
            TextSpan(
              text: commande!.getStatut(),
              style: FontUtils.getFontApp(
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, POLICE_MOBILE_NORMAL_1, POLICE_DESKTOP_NORMAL_1),
                color: commande!.getStatut() == "Annulé"
                    ? GRIS_CLAIR
                    : const Color.fromRGBO(0, 86, 27, 100),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getInfosArticles(BuildContext context, LigneCommande ligneCommande) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ResponsiveLayout(
            mobileBody: getArticleInfoMobile(ligneCommande),
            desktopBody: getArticleInfoDesktop(ligneCommande))
      ],
    );
  }

  Widget getArticleInfoMobile(LigneCommande ligneCommande) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ligneCommande.article.nom,
                style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_2),
              ),
              Text(
                ligneCommande.article.description,
                style: FontUtils.getFontApp(
                  fontSize: POLICE_MOBILE_NORMAL_2,
                  fontWeight: FONT_WEIGHT_NORMAL,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${ligneCommande.article.prix.toStringAsFixed(2)}€",
                    style: FontUtils.getFontApp(
                      fontSize: POLICE_MOBILE_NORMAL_2,
                    ),
                  ),
                  Text("x ${ligneCommande.quantite}",
                      style: FontUtils.getFontApp(
                          fontSize: POLICE_MOBILE_NORMAL_2)),
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget getArticleInfoDesktop(LigneCommande ligneCommande) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${ligneCommande.article.nom}\n",
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                        ),
                      ),
                      TextSpan(
                        text: ligneCommande.article.description,
                        style: FontUtils.getFontApp(
                          fontSize: POLICE_DESKTOP_NORMAL_2,
                          fontWeight: FONT_WEIGHT_NORMAL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${ligneCommande.article.prix.toStringAsFixed(2)}€",
                style: FontUtils.getFontApp(
                  fontSize: POLICE_DESKTOP_NORMAL_2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 10),
                child: Text("x ${ligneCommande.quantite}",
                    style: FontUtils.getFontApp(
                        fontSize: POLICE_DESKTOP_NORMAL_2)),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget getBoutons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (commande!.statut == StatutCommande.VALIDEE && !commande!.estPaye)
        BoutonAction(
          text: "Annuler ma commande",
          themeCouleur: ThemeCouleur.rouge,
          fonction: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => PopupAnnulationCommande(
                commandeProvider: commandeProvider,
                idCommande: commande!.id,
                fetchCommande: () => fetchCommande(),
              ),
            );
          },
        ),
      if (commande!.statut == StatutCommande.A_RETIRER)
        BoutonAction(
          text: "Retirer ma commande",
          fonction: () {
            afficherQRCode();
          },
        ),
      if (commande!.statut == StatutCommande.RETIREE ||
          commande!.statut == StatutCommande.CLOTUREE)
        BoutonAction(
          text: "Voir ma facture",
          fonction: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return PdfPreview(
                  pdfFileName:
                      "Commande n°${commande!.getNumeroCommande()}.pdf",
                  actionBarTheme: const PdfActionBarTheme(
                    backgroundColor: BEIGE_FONCE,
                    textStyle: TextStyle(color: NOIR),
                    iconColor: NOIR,
                  ),
                  canDebug: false,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  build: (context) {
                    ExportPdf export = ExportPdf();
                    return export.savePdf(commande!);
                  },
                );
              }),
            );
          },
        ),
    ]);
  }

  Widget getPrixTotal(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Prix total : ${commande!.getPrixTotal()} €",
          style: FontUtils.getFontApp(
            fontSize: ResponsiveConstraint.getResponsiveValue(
                context, POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
          ),
        ),
      ),
    );
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  void afficherQRCode() async {
    await commandeProvider.getQrCodeCommande(
        utilisateurProvider.token!, commande!.id);
    Image qrCode = imageFromBase64String(commandeProvider.qrCode);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Popup(
          titre: "Commande n° ${commande!.getNumeroCommande()}",
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "${commande!.utilisateur.prenom} ${commande!.utilisateur.nom}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: qrCode,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
