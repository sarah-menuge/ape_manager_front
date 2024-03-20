import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class PartageReseau {
  static void shareText(String nom_evenement, DateTime? date_debut,
      DateTime? date_fin, String lien,
      {String subject = '', Rect? sharePositionOrigin}) async {
    String formattedDateDebut =
        date_debut != null ? DateFormat('dd/MM/yyyy').format(date_debut) : "";
    String formattedDateFin =
        date_fin != null ? DateFormat('dd/MM/yyyy').format(date_fin) : "";

    var text =
        "Salut !\n\nPetit message pour partager que l'association de parents d'élèves de l'école Sainte Marie à Pérenchies lance l'évènement \"$nom_evenement\" du $formattedDateDebut au $formattedDateFin. Super occasion de soutenir notre école et dénicher des pépites ! Cela se passe sur le site de l'APE.\n\nPour découvrir, c'est par ici : $lien.";
    await Share.share(text,
        subject: subject, sharePositionOrigin: sharePositionOrigin);
  }
}
