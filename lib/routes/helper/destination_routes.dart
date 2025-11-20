import 'package:flutter/material.dart';

class Destination {
  const Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const destinations = [
  Destination(
    label: 'Overview',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
  ),
  Destination(
    label: 'Transaction',
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long,
  ),
  Destination(
    label: 'Report',
    icon: Icons.bar_chart_outlined,
    selectedIcon: Icons.bar_chart_rounded,
  ),
  Destination(
    label: 'Reminder',
    icon: Icons.settings,
    selectedIcon: Icons.settings_rounded,
  ),
  Destination(
    label: 'Account',
    icon: Icons.person,
    selectedIcon: Icons.person_rounded,
  ),
];
