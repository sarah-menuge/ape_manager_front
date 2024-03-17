import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';

class Tuile extends StatelessWidget {
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final bool prendLargeurTotal;
  final Widget body;
  final bool scrollable;

  const Tuile({
    super.key,
    this.maxWidth = 1300,
    this.minHeight = 200,
    this.maxHeight = 300,
    this.prendLargeurTotal = true,
    required this.body,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return prendLargeurTotal
        ? getTuile()
        : Expanded(
            child: getTuile(),
          );
  }

  Widget getTuile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: maxWidth,
        constraints: BoxConstraints(
            maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: GRIS_CLAIR,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [body],
          ),
        ),
      ),
    );
  }
}
