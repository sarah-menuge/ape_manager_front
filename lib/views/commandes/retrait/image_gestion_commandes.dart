import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ImageGestionCommandes extends StatelessWidget {
  const ImageGestionCommandes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:
          ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          width: double.infinity,
          child: const Image(
            image: AssetImage("assets/images/colis.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height:
          ResponsiveConstraint.getResponsiveValue(context, 160.0, 325.0),
          child: Center(
            child: Text(
              "Commandes à retirer",
              textDirection: TextDirection.ltr,
              style: FontUtils.getFontApp(
                color: Colors.white,
                shadows: true,
                fontSize: ResponsiveConstraint.getResponsiveValue(
                    context, 30.0, 60.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
