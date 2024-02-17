import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout({required this.mobileBody, required this.desktopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileBody;
        }
        return desktopBody;
      },
    );
  }
}

class ResponsiveConstraint {
  static getResponsiveValue(BuildContext context, mobileValue, desktopValue) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) {
      return mobileValue;
    }
    return desktopValue;
  }
}
