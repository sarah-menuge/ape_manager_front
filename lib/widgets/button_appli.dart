import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class BoutonNavigation extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final String routeName;
  final Object? arguments;

  const BoutonNavigation({
    required this.text,
    required this.background,
    required this.foreground,
    required this.routeName,
    this.arguments = null,
  });

  @override
  Widget build(BuildContext context) {
    return BoutonAction(
      text: text,
      background: background,
      foreground: foreground,
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

class BoutonAction extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final Function? fonction;
  final bool disable;

  const BoutonAction(
      {required this.text,
      required this.background,
      required this.foreground,
      required this.fonction,
      this.disable = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onHover: null,
      onPressed: disable
          ? null
          : () {
              fonction!();
            },
      style: ElevatedButton.styleFrom(
        foregroundColor: foreground,
        backgroundColor: background,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class BoutonRetour extends StatelessWidget {
  const BoutonRetour({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.pop(context)),
      ],
    );
  }
}
