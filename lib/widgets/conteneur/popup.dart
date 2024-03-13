import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/widgets/conteneur/header_popup.dart';
import 'package:ape_manager_front/widgets/conteneur/titre_popup.dart';
import 'package:ape_manager_front/widgets/texte/texte_flexible.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Popup extends StatelessWidget {
  final HeaderPopup? header;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final String titre;
  final String? sousTitre;
  final Widget body;

  const Popup({
    super.key,
    required this.titre,
    required this.body,
    this.header = const HeaderPopup(),
    this.sousTitre,
    this.minWidth = 0.0,
    this.minHeight = 0.0,
    this.maxWidth = 700,
    this.maxHeight = 700,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: BLANC_CASSE,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: BEIGE_CLAIR,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: minHeight,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return StickyHeader(
              header: header != null ? header! : const SizedBox(height: 20),
              content: Column(
                children: [
                  TitrePopup(titre: titre),
                  if (sousTitre != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TexteFlexible(
                        texte: sousTitre!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ResponsiveConstraint.getResponsiveValue(
                              context, 15, 17),
                        ),
                      ),
                    ),
                  body,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
