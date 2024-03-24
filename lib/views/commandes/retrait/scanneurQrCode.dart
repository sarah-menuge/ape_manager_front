import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../widgets/conteneur/popup.dart';

class ScanneurQrCode extends StatefulWidget {
  final Function(String)? actionScan;

  ScanneurQrCode({Key? key, this.actionScan}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanneurQrCodeState();
}

class _ScanneurQrCodeState extends State<ScanneurQrCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controlleur;
  String scanResult = '';
  bool estScanne = false;
  bool estValide = false;
  bool enExecution = false;

  @override
  Widget build(BuildContext context) {

    return Popup(
      titre: 'Scanneur de QR code',
      sousTitre: 'Veuillez scanner le QR code de la commande',
      body: Container(
        height: estScanne ? 250 : 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!estScanne)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
              ),
            if (estScanne && estValide)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Icon(Icons.check_circle, size: 100, color: Colors.green),
              ),
            if (estScanne && !estValide)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.cancel, size: 100, color: Colors.red),
                    Text("QR code non valide"),
                  ],
                ),
              ),
            BoutonAction(
              fonction: () => Navigator.of(context).pop(),
              text: 'Fermer',
              themeCouleur: ThemeCouleur.rouge,
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controlleur = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!enExecution) {
        enExecution = true;
        setState(() {
          estScanne = true;
          estValide = scanData.code != null &&
              scanData.code!.startsWith(URL_API + '#/commandes/');
        });

        if (estValide) {
          widget.actionScan?.call(scanData.code!);
        } else {
          Future.delayed(Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                estScanne = false;
                enExecution = false;
              });
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    controlleur?.dispose();
    super.dispose();
  }
}
