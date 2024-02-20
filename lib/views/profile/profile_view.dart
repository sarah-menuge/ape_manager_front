import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/profile/profile_view_desktop.dart';
import 'package:ape_manager_front/views/profile/profile_view_mobile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  static String routeName = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      width: 1230,
      mobileBody: ProfileViewMobile(),
      desktopBody: ProfileViewDesktop(),
    );
  }
}
