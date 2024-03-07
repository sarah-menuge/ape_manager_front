import 'package:ape_manager_front/widgets/loader.dart';
import 'package:flutter/material.dart';

class GestionChargementFormulaire extends StatelessWidget {
  final Widget body;
  final bool chargement;

  const GestionChargementFormulaire(
      {super.key, required this.body, required this.chargement});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        chargement == true ? const Loader() : const SizedBox(),
        Center(child: body),
      ],
    );
  }
}
