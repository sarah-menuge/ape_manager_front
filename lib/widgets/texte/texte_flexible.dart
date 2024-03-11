import 'package:flutter/material.dart';

class TexteFlexible extends StatelessWidget {
  // Texte à afficher
  final String texte;
  final TextStyle? style;
  final TextAlign? textAlign;
  // Est-ce que le texte est déjà contenu immédiatement dans un row ?
  final bool dejaContenuDansUnRow;

  const TexteFlexible({
    super.key,
    required this.texte,
    this.style,
    this.textAlign,
    this.dejaContenuDansUnRow = false,
  });

  @override
  Widget build(BuildContext context) {
    if (dejaContenuDansUnRow) {
      return Expanded(
        child: Text(
          texte,
          style: style,
          textAlign: textAlign,
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            texte,
            textAlign: textAlign,
            style: style,
          ),
        ),
      ],
    );
  }
}
