import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:flutter/material.dart';

enum ThemeCouleur { vert, gris, rouge, bleu, bleu_clair }

abstract class Bouton extends StatelessWidget {
  const Bouton({super.key});

  @override
  Widget build(BuildContext context);
}

class BoutonNavigation extends Bouton {
  final String text;
  final String routeName;
  final Object? arguments;
  final ThemeCouleur themeCouleur;

  const BoutonNavigation({
    super.key,
    required this.text,
    required this.routeName,
    this.arguments,
    this.themeCouleur = ThemeCouleur.bleu,
  });

  @override
  Widget build(BuildContext context) {
    return BoutonAction(
      text: text,
      themeCouleur: themeCouleur,
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

  const BoutonAction({
    super.key,
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
      backgroundColor = VERT_FONCE;
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
  final String nomUrlRetour;

  const BoutonRetour({
    super.key,
    this.invisibleEtNonCliquable = false,
    this.nomUrlRetour = "",
  });

  @override
  Widget build(BuildContext context) {
    if (invisibleEtNonCliquable) {
      return Opacity(opacity: 0.0, child: getBouton(context));
    }
    return getBouton(context);
  }

  Widget getBouton(BuildContext context) {
    Function()? onPressed = invisibleEtNonCliquable
        ? null
        : () => revenirEnArriere(context, routeURL: nomUrlRetour);
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

  const BoutonIcon({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: onPressed);
  }
}

class BoutonNavigationGoRouter extends Bouton {
  final String text;
  final String routeName;
  final bool disable;
  final ThemeCouleur themeCouleur;

  const BoutonNavigationGoRouter({
    super.key,
    required this.text,
    required this.routeName,
    this.disable = false,
    this.themeCouleur = ThemeCouleur.bleu,
  });

  @override
  Widget build(BuildContext context) {
    return BoutonAction(
      text: text,
      fonction: () => naviguerVersPage(
        context,
        routeName,
      ),
      themeCouleur: themeCouleur,
      disable: disable,
    );
  }
}
