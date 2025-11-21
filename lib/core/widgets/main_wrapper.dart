import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/constant/navigation_items.dart";

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: colorScheme.primary.withValues(alpha: 0.1),

          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              );
            }
            return TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            );
          }),
        ),
        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: colorScheme.surface,
          surfaceTintColor: colorScheme.surface,
          elevation: 0,

          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          destinations: destinations
              .map(
                (destination) => NavigationDestination(
                  icon: Icon(
                    destination.icon,
                    color: colorScheme.onSurfaceVariant,
                  ),
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
