
import 'package:ape_manager_front/views/profile/TableEnfantDesktop.dart';
import 'package:ape_manager_front/views/profile/TableEnfantMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';

class TableEnfants extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      width: 1230,
      mobileBody: TableEnfantsMobile(),
      desktopBody: TableEnfantsDesktop(),
    );
  }
}
