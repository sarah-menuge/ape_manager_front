import 'dart:convert';

import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../utils/partage_reseau.dart';
import '../../../widgets/button_appli.dart';
import '../../../widgets/conteneur/popup.dart';

class PopupPartage extends StatefulWidget {
  final String titreEvenement;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final String lien;
  final String b64QRCode = B64QRCODE;

  const PopupPartage({
    Key? key,
    required this.titreEvenement,
    required this.dateDebut,
    required this.dateFin,
    required this.lien,
  }) : super(key: key);

  @override
  State<PopupPartage> createState() => _PopupPartageState();
}

class _PopupPartageState extends State<PopupPartage> {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  void partagerAvecQRCode() {
    Image test = imageFromBase64String(widget.b64QRCode);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Popup(
          titre: 'QR Code',
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: test,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                BoutonAction(
                  text: 'Partager via les réseaux',
                  fonction: partagerViaReseaux,
                  themeCouleur: ThemeCouleur.vert,
                ),
              ],
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
