import 'dart:convert';

import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/evenement_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../utils/partage_reseau.dart';
import '../../../widgets/button_appli.dart';
import '../../../widgets/conteneur/popup.dart';

class PopupPartage extends StatefulWidget {
  final int idEvenement;
  final String titreEvenement;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final String lien;

  // final String b64QRCode = B64QRCODE;

  const PopupPartage({
    Key? key,
    required this.idEvenement,
    required this.titreEvenement,
    required this.dateDebut,
    required this.dateFin,
    required this.lien,
  }) : super(key: key);

  @override
  State<PopupPartage> createState() => _PopupPartageState();
}

class _PopupPartageState extends State<PopupPartage> {
  late UtilisateurProvider utilisateurProvider;
  late EvenementProvider evenementProvider;
  late Image? qrCode;

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    evenementProvider = Provider.of<EvenementProvider>(context, listen: false);
    getQRCode();
  }

  void getQRCode() async {
    await evenementProvider.getQrCodeEvenement(
        utilisateurProvider.token!, widget.idEvenement);
    setState(() {
      qrCode = Image.memory(base64Decode(evenementProvider.qrCode));
    });
  }

  void partagerAvecQRCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return qrCode == null
            ? const Text("QR code non disponible")
            : Popup(
                titre: 'QR Code',
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: qrCode,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Scannez ce QR code pour accéder à l\'événement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  void partagerViaReseaux() {
    PartageReseau.shareText(
      widget.titreEvenement,
      widget.dateDebut,
      widget.dateFin,
      widget.lien,
    );
  }

  void partagerParMail() {}

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: 'Options de partage',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: BoutonAction(
                  text: 'Partager avec un QR code',
                  fonction: partagerAvecQRCode,
                  themeCouleur: ThemeCouleur.bleu,
                ),
              ),
              if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: BoutonAction(
                    text: 'Partager via les réseaux',
                    fonction: partagerViaReseaux,
                    themeCouleur: ThemeCouleur.vert,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
