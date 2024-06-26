import 'package:ape_manager_front/models/utilisateur.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_email.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_select_simple.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_string.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_telephone.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';

class PopupConsultationModificationUtilisateur extends StatelessWidget {
  final Utilisateur utilisateur;
  final Function fonctionModification;
  final bool consultation;

  const PopupConsultationModificationUtilisateur({
    super.key,
    required this.utilisateur,
    this.consultation = false,
    required this.fonctionModification,
  });

  @override
  Widget build(BuildContext context) {
    return Popup(
      titre:
          '${consultation ? 'Consultation' : 'Modification'} d\' un utilisateur',
      body: ConsultationModificationUtilisateurFormView(
        utilisateur: utilisateur,
        consultation: consultation,
        fonctionModification: fonctionModification,
      ),
    );
  }
}

class ConsultationModificationUtilisateurFormView extends StatefulWidget {
  final Function fonctionModification;
  final Utilisateur utilisateur;
  final bool consultation;

  const ConsultationModificationUtilisateurFormView(
      {super.key,
      required this.utilisateur,
      required this.consultation,
      required this.fonctionModification});

  @override
  State<ConsultationModificationUtilisateurFormView> createState() =>
      _ConsultationModificationUtilisateurFormViewState();
}

class _ConsultationModificationUtilisateurFormViewState
    extends FormulaireState<ConsultationModificationUtilisateurFormView> {
  late RoleUtilisateur role;

  @override
  Formulaire setFormulaire(BuildContext context) {
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      champs: [
        [
          ChampString(
            prefixIcon: const Icon(Icons.person),
            label: "Nom de l'utilisateur",
            valeurInitiale: widget.utilisateur.nom,
            onSavedMethod: (value) => widget.utilisateur.nom = value!,
            readOnly: widget.consultation,
          ),
        ],
        [
          ChampString(
            prefixIcon: const Icon(Icons.person_outline),
            label: "Prénom de l'utilisateur",
            valeurInitiale: widget.utilisateur.prenom,
            onSavedMethod: (value) => widget.utilisateur.prenom = value!,
            readOnly: widget.consultation,
          ),
        ],
        [
          ChampEmail(
            label: "Email de l'utilisateur",
            valeurInitiale: widget.utilisateur.email,
            onSavedMethod: (value) => widget.utilisateur.email = value!,
            readOnly: widget.consultation,
          ),
        ],
        [
          ChampTelephone(
            label: "Téléphone de l'utilisateur",
            valeurInitiale: widget.utilisateur.telephone,
            onSavedMethod: (value) => widget.utilisateur.telephone = value!,
            readOnly: widget.consultation,
          ),
        ],
        [
          if (!widget.consultation) ...[
            ChampSelectSimple(
                label: "Rôle de l'utilisateur",
                valeurInitiale:
                    widget.utilisateur.roleToString(widget.utilisateur.role),
                prefixIcon: Icon(Icons.manage_accounts),
                onSavedMethod: (value) => widget.utilisateur.role =
                    widget.utilisateur.stringToRole(value!),
                valeursExistantes: widget.utilisateur.roles()),
          ] else
            ChampString(
              prefixIcon: const Icon(Icons.manage_accounts),
              label: "Rôle de l'utilisateur",
              valeurInitiale:
                  widget.utilisateur.roleToString(widget.utilisateur.role),
              onSavedMethod: (value) => widget.utilisateur.role =
                  widget.utilisateur.stringToRole(value!),
              readOnly: true,
            ),
        ],
        [
          CheckboxListTile(
            value: widget.utilisateur.est_membre,
            onChanged: widget.consultation
                ? null
                : (bool? value) {
                    setState(() {
                      widget.utilisateur.est_membre = value!;
                    });
                  },
            title: const Text('Est membre CA ?'),
          ),
        ],
      ],
      boutons: [
        if (!widget.consultation)
          BoutonAction(
            text: "Modifier l'utilisateur",
            fonction: () => appuiBoutonModifier(),
            disable: desactiverBoutons,
          ),
      ],
    );
  }

  void appuiBoutonModifier() {
    resetMessageErreur();
    if (!chargement && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appelMethodeAsynchrone(() {
        widget.fonctionModification(widget.utilisateur);
      });
    }
  }
}
