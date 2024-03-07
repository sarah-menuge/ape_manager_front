import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/widgets/conteneur/header_div_principale.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class DivPrincipale extends StatelessWidget {
  final HeaderDivPrincipale? header;
  final Widget body;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

  const DivPrincipale({
    super.key,
    required this.body,
    this.header = const HeaderDivPrincipale(),
    this.minWidth = 0.0,
    this.minHeight = 0.0,
    this.maxWidth = 1000,
    this.maxHeight = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              ResponsiveConstraint.getResponsiveValue(context, 10.0, 50.0),
          vertical:
              ResponsiveConstraint.getResponsiveValue(context, 35.0, 40.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: BEIGE_CLAIR,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          constraints: BoxConstraints(
            minWidth: minWidth,
            minHeight: minHeight,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
          padding: EdgeInsets.only(top: 15),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return StickyHeader(
                header: header != null ? header! : const SizedBox(),
                content: Column(
                  children: [body],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
