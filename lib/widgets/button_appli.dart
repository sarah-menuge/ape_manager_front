import 'package:flutter/material.dart';

class ButtonAppli extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final String routeName;

  const ButtonAppli(
      {required this.text,
      required this.background,
      required this.foreground,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          routeName,
        );
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
