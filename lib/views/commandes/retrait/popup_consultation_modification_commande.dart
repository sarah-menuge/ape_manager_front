import 'package:ape_manager_front/models/commande.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_date.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_double.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupConsultationModificationCommande extends StatelessWidget {
  final Commande commande;
  final Function fetchCommandes;
  final Function retirerCommande;
  final bool consultation;

  const PopupConsultationModificationCommande({
    super.key,
    required this.commande,
    required this.fetchCommandes,
    required this.retirerCommande,
    this.consultation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre:
          '${consultation ? 'Consultation' : 'Modification'} d\' une commande',
      body: ConsultationModificationCommandeFormView(
        commande: commande,
        fetchCommandes: fetchCommandes,
        retirerCommande: retirerCommande,
        consultation: consultation,
      ),
    );
  }
}

class ConsultationModificationCommandeFormView extends StatefulWidget {
  final Function fetchCommandes;
  final Function retirerCommande;
  final Commande commande;
  final bool consultation;

  const ConsultationModificationCommandeFormView(
      {super.key,
      required this.commande,
      required this.fetchCommandes,
      required this.retirerCommande,
      required this.consultation});

  @override
  State<ConsultationModificationCommandeFormView> createState() =>
      _ConsultationModificationCommandeFormViewState();
}

class _ConsultationModificationCommandeFormViewState
    extends FormulaireState<ConsultationModificationCommandeFormView> {
  @override
  Formulaire setFormulaire(BuildContext context) {
    String numeroCommande = widget.commande.getNumeroCommande();
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            prefixIcon: const Icon(Icons.receipt),
            label: "ID de la commande",
            readOnly: true,
            valeurInitiale: numeroCommande,
          ),
        ],
        [
          ChampString(
              prefixIcon: const Icon(Icons.person),
              label: "Nom du client",
              readOnly: true,
              valeurInitiale: widget.commande.nomUtilisateur),
        ],
        [
          ChampDouble(
            prefixIcon: const Icon(Icons.euro),
            label: "Prix de la commande",
            valeurInitiale: widget.commande.prixTotal != 0.0
                ? widget.commande.prixTotal as double
                : 0.0,
            onSavedMethod: (value) {
              widget.commande.prixTotal = double.parse(value!);
            },
            readOnly: widget.consultation,
          ),
        ],
        [
          ChampDate(
              prefixIcon: const Icon(Icons.calendar_today),
              label: "Date de création",
              readOnly: true,
              valeurInitiale: widget.commande.dateCreation.year.toString() +
                  "-" +
                  widget.commande.dateCreation.month.toString() +
                  "-" +
                  widget.commande.dateCreation.day.toString()),
          ChampString(
              prefixIcon: const Icon(Icons.place),
              label: "Lieu de retrait",
              readOnly: true,
              valeurInitiale: widget.commande.lieuRetrait.lieu),
        ],
        [
          ChampString(
              prefixIcon: const Icon(Icons.event),
              label: "Statut de la commande",
              readOnly: true,
              valeurInitiale:
                  widget.commande.statut.toString().split('.').last),
        ],
        [
          CheckboxListTile(
            value: widget.commande.estPaye,
            onChanged: widget.consultation
                ? null
                : (bool? value) {
                    setState(() {
                      widget.commande.estPaye = value!;
                    });
                  },
            title: const Text('Est Payée ?'),
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Valider le retrait de la commande",
          fonction: () => widget.retirerCommande(widget.commande.id),
          disable: desactiverBoutons,
        ),
      ],
    );
  }

}
