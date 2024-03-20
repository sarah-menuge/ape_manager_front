import 'dart:collection';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class ExportExcel {
  var excel;
  Map<String, dynamic> sheets = HashMap();

  ExportExcel() {
    excel = Excel.createExcel();
  }

  void ajouterFeuille(String nomFeuille, bool pageDefaut) {
    // Crée une feuille et la met par défaut s'il le faut
    sheets.addAll({nomFeuille: excel[nomFeuille]});
    if (pageDefaut) excel.setDefaultSheet(nomFeuille);
  }

  void ecrireDansCellule(String nomFeuille, String cellule, dynamic valeur) {
    // Permet d'écrire dans une cellule spécifique
    var cell = sheets[nomFeuille].cell(CellIndex.indexByString(cellule));
    cell.value = TextCellValue(valeur);
  }

  void ajouterValeurs(
      String nomFeuille, List<String> listeHeader, Map<String, int?> valeurs) {
    int colonneIndex = 0;

    for (String header in listeHeader) {
      // Création du header
      var celluleHeader = sheets[nomFeuille].cell(
          CellIndex.indexByColumnRow(columnIndex: colonneIndex, rowIndex: 0));
      celluleHeader.value = TextCellValue(header);
      CellStyle celluleStyle = CellStyle(bold: true);
      celluleHeader.cellStyle = celluleStyle;
      sheets[nomFeuille].setColumnWidth(colonneIndex, header.length * 2.0);

      colonneIndex++;
    }

    int rowIndex = 1;
    valeurs.forEach((String cle, int? valeur) {
      if (valeur != null) {
        var celluleString = sheets[nomFeuille].cell(
            CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex));
        celluleString.value = TextCellValue(cle);

        var celluleInt = sheets[nomFeuille].cell(
            CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
        celluleInt.value = TextCellValue(valeur.toString());

        rowIndex++;
      }
    });
  }

  Future<void> enregistrerExcel(BuildContext context, String nomFichier) async {
    return excel.save(fileName: '$nomFichier.xlsx');
  }
}
