import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../proprietes/couleurs.dart';
import '../../../utils/rappel_calendrier.dart';
import '../../../widgets/button_appli.dart';
import '../../../widgets/conteneur/popup.dart';

class NotificationPopup extends StatefulWidget {
  final String titreEvenement;
  final DateTime dateDebut;

  const NotificationPopup({
    Key? key,
    required this.titreEvenement,
    required this.dateDebut,
  }) : super(key: key);

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  bool _ajouterAuCalendrier = false;
  bool _rappelerParMail = false;

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre: 'Options de notification',
      body: Column(
        children: [
          if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)
            CheckboxListTile(
              title: const Text('Ajouter un rappel au calendrier'),
              value: _ajouterAuCalendrier,
              onChanged: (bool? value) {
                setState(() {
                  _ajouterAuCalendrier = value!;
                });
              },
            ),
          CheckboxListTile(
            title: const Text('Me rappeler par mail'),
            value: _rappelerParMail,
            onChanged: (bool? value) {
              afficherLogCritical("Me rappeler par mail non pris en charge");
              setState(() {
                _rappelerParMail = value!;
              });
            },
          ),
          BoutonAction(
            text: 'Valider',
            themeCouleur: ThemeCouleur.vert,
            fonction: () async {
              if (_ajouterAuCalendrier &&
                  (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)) {
                String? result = await CalendarService.addReminder(
                  title: "Evenement École : ${widget.titreEvenement}",
                  start: DateTime(
                    widget.dateDebut.year,
                    widget.dateDebut.month,
                    widget.dateDebut.day,
                    8,
                  ),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(result ?? "Erreur lors de l'ajout du rappel."),
                    duration: const Duration(seconds: 3),
                    backgroundColor: result == "Rappel ajouté avec succès."
                        ? VERT_1
                        : ROUGE_1,
                  ),
                );
              }
              // TODO: Gérer le rappel par mail
              if (_rappelerParMail) {}
            },
          ),
        ],
      ),
    );
  }
}
