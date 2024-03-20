import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/models/ligne_commande.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ExportPdf {
  ExcelPdf() {}

  Future<Uint8List> savePdf(Commande commande) async {
    final pdf = Document();
    final fontData =
        await rootBundle.load('assets/fonts/Oswald-VariableFont_wght.ttf');
    final font = Font.ttf(fontData);
    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/images/logoEcole.png'))
            .buffer
            .asUint8List());

    pdf.addPage(
      Page(
        build: (Context context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                          "À l'attention de : ${commande.utilisateur.prenom} ${commande.utilisateur.nom}",
                          style: TextStyle(font: font)),
                      Text(commande.utilisateur.email,
                          style: TextStyle(font: font)),
                      Text(commande.utilisateur.telephone,
                          style: TextStyle(font: font)),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(imageLogo),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 100, bottom: 20),
                child: Table(
                  border: TableBorder.all(color: PdfColors.black),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'ARTICLE',
                            style: TextStyle(font: font),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Padding(
                          child: Text(
                            'QUANTITÉ',
                            style: TextStyle(font: font),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Padding(
                          child: Text(
                            'PRIX UNITAIRE',
                            style: TextStyle(font: font),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Padding(
                          child: Text(
                            'MONTANT',
                            style: TextStyle(font: font),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                    for (LigneCommande ligneCommande
                        in commande.listeLigneCommandes)
                      TableRow(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                ligneCommande.article.nom,
                                style: TextStyle(font: font, fontSize: 10),
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text(
                              ligneCommande.quantite.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(font: font, fontSize: 10),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "${ligneCommande.article.prix.toStringAsFixed(2)} €",
                              textAlign: TextAlign.center,
                              style: TextStyle(font: font, fontSize: 10),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "${(ligneCommande.quantite * ligneCommande.article.prix).toStringAsFixed(2)} €",
                              textAlign: TextAlign.center,
                              style: TextStyle(font: font, fontSize: 10),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Total",
                            style: TextStyle(font: font, fontSize: 10),
                          ),
                        ),
                        Text(
                          commande.nombreArticles.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(font: font, fontSize: 10),
                        ),
                        Text(
                          "",
                          style: TextStyle(font: font, fontSize: 10),
                        ),
                        Text(
                          "${commande.getPrixTotal()} €",
                          textAlign: TextAlign.center,
                          style: TextStyle(font: font, fontSize: 10),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Text(
                "MERCI POUR VOTRE COMMANDE !",
                style: TextStyle(font: font, fontSize: 10),
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
