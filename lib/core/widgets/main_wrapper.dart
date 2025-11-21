import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/constant/navigation_items.dart";

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // Capture theme
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Adaptive Scaffold Background
      backgroundColor: colorScheme.surface,
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // Adaptive Indicator: Blue with 10% opacity
          indicatorColor: colorScheme.primary.withValues(alpha: 0.1),

          // Dynamic Label Text Colors
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: colorScheme.primary, // Brand Blue
                fontWeight: FontWeight.w600,
                fontSize: 12,
              );
            }
            return TextStyle(
              color: colorScheme.onSurfaceVariant, // Adaptive Grey
              fontWeight: FontWeight.w500,
              fontSize: 12,
            );
          }),
        ),
        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          // Adaptive Bar Background
          backgroundColor: colorScheme.surface,
          surfaceTintColor:
              colorScheme.surface, // Remove tint if you prefer flat look
          elevation: 0, // Optional: Add elevation or shadow if needed

          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          destinations: destinations
              .map(
                (destination) => NavigationDestination(
                  // Unselected Icon (Grey)
                  icon: Icon(
                    destination.icon,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  // Selected Icon (Blue)
                  selectedIcon: Icon(
                    destination.selectedIcon,
                    color: colorScheme.primary,
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
