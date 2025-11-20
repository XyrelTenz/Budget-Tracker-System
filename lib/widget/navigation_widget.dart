import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import "package:smart_budget_ph/routes/helper/destination_routes.dart";

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({Key? key, required this.navigationShell})
    : super(key: key ?? const ValueKey<String>('NavigationWidget'));

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: navigationShell,

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: const Color(0x1A2563EB)),

        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          destinations: destinations
              .map(
                (destination) => NavigationDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: destination.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
