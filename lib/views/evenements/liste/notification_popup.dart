import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/rappel_calendrier.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class NotificationPopup extends StatefulWidget {
  final int idEvenement;
  final String titreEvenement;
  final DateTime dateDebut;
  final bool utilisateurNotifie;
  final Function? modifierUtilisateurNotifie;

  const NotificationPopup({
    super.key,
    required this.idEvenement,
    required this.titreEvenement,
    required this.dateDebut,
    required this.utilisateurNotifie,
    this.modifierUtilisateurNotifie,
  });

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  bool ajouteAuCalendrier = false;
  late bool utilisateurNotifie;
  late bool utilisateurNotifieInitial;
  late UtilisateurProvider utilisateurProvider;
  Function? fonctionMessage;
  String? message;

  @override
  void initState() {
    super.initState();
    utilisateurProvider =
        Provider.of<UtilisateurProvider>(context, listen: false);
    utilisateurNotifie = widget.utilisateurNotifie;
    utilisateurNotifieInitial = utilisateurNotifie;
  }

  @override
  Widget build(BuildContext context) {
    if (fonctionMessage != null) fonctionMessage!(context, message!);
    fonctionMessage = null;
    message = null;

    return Popup(
      titre: 'Options de notification',
      body: Column(
        children: [
          if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)
            CheckboxListTile(
              title: const Text('Ajouter un rappel au calendrier'),
              value: ajouteAuCalendrier,
              onChanged: (bool? value) {
                setState(() => ajouteAuCalendrier = value!);
              },
            ),
          CheckboxListTile(
            title: const Text('Me rappeler par mail'),
            value: utilisateurNotifie,
            onChanged: (bool? value) {
              setState(() => utilisateurNotifie = value!);
            },
          ),
          BoutonAction(
            text: 'Valider',
            themeCouleur: ThemeCouleur.vert,
            fonction: () {
              bool modification = false;
              if (ajouteAuCalendrier &&
                  (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)) {
                modification = true;
                ajouterAuCalendrier();
              }
              if (utilisateurNotifieInitial != utilisateurNotifie) {
                modification = true;
                switchRappelerParMail();
              }

              if (!modification) {
                afficherMessageInfo(
                    context: context,
                    message: "Aucune modification n'a été apportée.");
              }
              revenirEnArriere(context);
            },
          ),
        ],
      ),
    );
  }

  void ajouterAuCalendrier() async {
    String? result = await CalendarService.addReminder(
      title: "Evenement École : ${widget.titreEvenement}",
      start: DateTime(
        widget.dateDebut.year,
        widget.dateDebut.month,
        widget.dateDebut.day,
        8,
      ),
    );
    if (result == "Rappel ajouté avec succès." && mounted) {
      String r = result!;
      if (r == "Rappel ajouté avec succès.") {
        afficherMessageSucces(
          context: context,
          message: "L'événement a bien été ajouté à votre calendrier.",
        );
      } else {
        afficherMessageErreur(
          context: context,
          message: "L'événement n'a pas pu être ajouté à votre calendrier.",
        );
      }
    }
  }

  void switchRappelerParMail() async {
    final response = await utilisateurProvider.meNotifierParMailEvenement(
      utilisateurProvider.token!,
      widget.idEvenement,
    );

    if (response["statusCode"] == 200 && mounted) {
      setState(() {
        utilisateurNotifieInitial = utilisateurNotifie;
      });
      if (widget.modifierUtilisateurNotifie != null) {
        widget.modifierUtilisateurNotifie!(
          widget.idEvenement,
          utilisateurNotifie,
        );
      }
      afficherMessageSucces(
          context: context,
          message: utilisateurNotifie == true
              ? "Vous avez bien été ajouté à la liste de diffusion de l'événement."
              : "Vous avez bien été retiré de la liste de diffusion de l'événement.");
    } else if (mounted) {
      afficherMessageErreur(context: context, message: response["message"]);
    }
  }
}
