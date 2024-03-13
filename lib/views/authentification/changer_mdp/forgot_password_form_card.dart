import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/views/authentification/changer_mdp/modification_mdp_form_view.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = 600;
          double width =
              constraints.maxWidth > maxWidth ? maxWidth : constraints.maxWidth;
          return Container(
            width: width,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: BEIGE_CLAIR,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: ModificationMdpFormView(),
            ),
          );
        },
      ),
    );
  }
}
