import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/constant/navigation_items.dart";

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = Color(0xFF0046FF);
    const Color unselectedColor = Color(0xFF313131);

    return Scaffold(
      backgroundColor: Colors.white,
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0x1A2563EB),

          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: selectedColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              );
            }
            return const TextStyle(
              color: unselectedColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            );
          }),
        ),
        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          destinations: destinations
              .map(
                (destination) => NavigationDestination(
                  icon: Icon(destination.icon, color: unselectedColor),
                  selectedIcon: Icon(
                    destination.selectedIcon,
                    color: selectedColor,
                  ),
                  label: destination.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
