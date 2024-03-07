import 'package:ape_manager_front/models/barre_navigation_item.dart';
import 'package:flutter/material.dart';

class BodyNavigationBar extends StatelessWidget {
  final List<BarreNavigationItem>? items;
  final int currentIndex;
  final ValueChanged<int> onTabTapped;

  const BodyNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _buildBottomNavBarItems(items!),
      currentIndex: currentIndex,
      onTap: onTabTapped,
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems(
      List<BarreNavigationItem> barreNavigationList) {
    List<BottomNavigationBarItem> bottomNavBarItems = [];
    barreNavigationList.forEach((barreNavigation) {
      bottomNavBarItems.add(BottomNavigationBarItem(
        icon: barreNavigation.icon,
        label: barreNavigation.label,
      ));
    });
    return bottomNavBarItems;
  }
}
