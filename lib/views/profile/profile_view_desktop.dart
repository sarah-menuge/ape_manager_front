import 'package:flutter/material.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';

import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';
import '../../widgets/TextTitre.dart';
import '../../widgets/footer_appli.dart';
import 'modification_enfants_form_view.dart';
import 'modification_utilisateur_form_view.dart';

class ProfileViewDesktop extends StatelessWidget {
  final bool initialReadOnly;

  const ProfileViewDesktop({Key? key, this.initialReadOnly = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderAppli(),
      body: StickyFooterScrollView(
        footer: const Footer(),
        itemBuilder: (BuildContext context, int index) {
          return BodyProfileView();
        },
        itemCount: 1,
      ),
    );
  }
}

class BodyProfileView extends StatelessWidget {
  const BodyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextTitre(titre: 'Mon Profil'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ModificationUtilisateurFormView(),
            Container(
                color: Colors.grey,
                child: const SizedBox(height: 500, width: 3)),
            ModificationEnfantsFormView(),
          ],
        ),
      ],
    );
  }
}
