import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ExportPdf {
  ExcelPdf() {}

  Future<Uint8List> savePdf() async {
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
                      Text("À l'attention de : Sarah Menuge",
                          style: TextStyle(font: font)),
                      Text("menuge_sarah@icloud.com",
                          style: TextStyle(font: font)),
                      Text("0762079691", style: TextStyle(font: font)),
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
                            'PRIX',
                            style: TextStyle(font: font),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Eau minérale",
                              style: TextStyle(font: font, fontSize: 10),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(
                            "10",
                            textAlign: TextAlign.center,
                            style: TextStyle(font: font, fontSize: 10),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            "15.87 €",
                            textAlign: TextAlign.center,
                            style: TextStyle(font: font, fontSize: 10),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                    TableRow(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Biscuit chocolaté",
                              style: TextStyle(font: font, fontSize: 10),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(
                            "3",
                            textAlign: TextAlign.center,
                            style: TextStyle(font: font, fontSize: 10),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            "5.96 €",
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
                          "13",
                          textAlign: TextAlign.center,
                          style: TextStyle(font: font, fontSize: 10),
                        ),
                        Text(
                          "21.83 €",
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
