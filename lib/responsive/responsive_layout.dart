import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  final int width;

  const ResponsiveLayout(
      {required this.mobileBody, required this.desktopBody, this.width = 600});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width < width) {
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

bool estDesktop(BuildContext context, int width) {
  return MediaQuery.of(context).size.width >= width;
}

bool estMobile(BuildContext context, int width) {
  return !estDesktop(context, width);
}
