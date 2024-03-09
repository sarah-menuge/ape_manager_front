import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

enum ThemeCouleur { vert, gris, rouge, bleu, bleu_clair }

abstract class Bouton extends StatelessWidget {
  @override
  Widget build(BuildContext context);
}

class BoutonNavigation extends Bouton {
  final String text;
  final String routeName;
  final Object? arguments;
  final ThemeCouleur themeCouleur;

  BoutonNavigation({
    required this.text,
    required this.routeName,
    this.arguments = null,
    this.themeCouleur = ThemeCouleur.bleu,
  });

  @override
  Widget build(BuildContext context) {
    return BoutonAction(
      text: text,
      fonction: () {
        Navigator.pushNamed(
          context,
          routeName,
          arguments: arguments,
        );
      },
    );
  }
}

class BoutonAction extends Bouton {
  final String text;
  final Function? fonction;
  final bool disable;
  final ThemeCouleur themeCouleur;

  BoutonAction({
    required this.text,
    required this.fonction,
    this.disable = false,
    this.themeCouleur = ThemeCouleur.bleu,
  });

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = GRIS_FONCE;
    Color backgroundColor = BLANC;
    if (themeCouleur == ThemeCouleur.bleu) {
      backgroundColor = BLEU;
      foregroundColor = BLANC;
    } else if (themeCouleur == ThemeCouleur.vert) {
      backgroundColor = VERT;
      foregroundColor = BLANC;
    } else if (themeCouleur == ThemeCouleur.rouge) {
      backgroundColor = ROUGE;
      foregroundColor = BLANC;
    } else if (themeCouleur == ThemeCouleur.gris) {
      backgroundColor = GRIS_FONCE;
      foregroundColor = BLANC;
    } else if (themeCouleur == ThemeCouleur.bleu_clair) {
      backgroundColor = BLEU_CLAIR;
      foregroundColor = BLANC;
    }
    return ElevatedButton(
      onHover: null,
      onPressed: disable
          ? null
          : () {
              fonction!();
            },
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal:
              ResponsiveConstraint.getResponsiveValue(context, 25.0, 20.0),
          vertical: ResponsiveConstraint.getResponsiveValue(context, 0.0, 10.0),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize:
              ResponsiveConstraint.getResponsiveValue(context, 12.0, null),
        ),
      ),
    );
  }
}

class BoutonRetour extends Bouton {
  // Permet entre autre de bien aligner un titre dans un header
  final bool invisibleEtNonCliquable;

  BoutonRetour({this.invisibleEtNonCliquable = false});

  @override
  Widget build(BuildContext context) {
    if (invisibleEtNonCliquable) {
      return Opacity(opacity: 0.0, child: getBouton(context));
    }
    return getBouton(context);
  }

  Widget getBouton(BuildContext context) {
    Function()? onPressed =
        invisibleEtNonCliquable ? null : () => Navigator.pop(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size:
                  ResponsiveConstraint.getResponsiveValue(context, 30.0, 40.0),
            ),
            onPressed: onPressed),
      ],
    );
  }
}

class BoutonIcon extends Bouton {
  final Icon icon;
  final Function()? onPressed;

  BoutonIcon({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: onPressed);
  }
}
