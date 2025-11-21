import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/routes/app_routes.dart";
import "package:smart_budget_ph/core/theme/theme_provider.dart";

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Capture Theme & Provider State
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Listen to current theme mode (Light/Dark/System)
    final currentThemeMode = ref.watch(themeProvider);
    final isDarkMode = currentThemeMode == ThemeMode.dark;

    return Scaffold(
      // Adaptive Background (Light Grey / Dark Background)
      backgroundColor: colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --- PROFILE HEADER ---
            _buildProfileHeader(colorScheme),

            const SizedBox(height: 30),

            // --- GENERAL SECTION ---
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                "General",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant, // Adaptive Grey
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // Adaptive Card Color
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    color: Colors.blue,
                    label: "Edit Profile",
                    onTap: () {},
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    color: Colors.orange,
                    label: "Notifications",
                    onTap: () {},
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.category_outlined,
                    color: Colors.purple,
                    label: "Categories",
                    onTap: () {},
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.file_download_outlined,
                    color: Colors.teal,
                    label: "Export Data",
                    onTap: () {},
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- PREFERENCES SECTION ---
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                "Preferences",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    color: Colors.pink,
                    label: "Security & Privacy",
                    onTap: () {},
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.language,
                    color: Colors.indigo,
                    label: "Language",
                    trailing: Text(
                      "English",
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {},
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),

                  // --- DARK MODE SWITCH ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.dark_mode,
                            color: colorScheme.onSurface,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Dark Mode",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Switch(
                          value: isDarkMode,
                          activeThumbColor: colorScheme.primary,
                          onChanged: (val) {
                            if (val) {
                              ref.read(themeProvider.notifier).setDark();
                            } else {
                              ref.read(themeProvider.notifier).setLight();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- LOGOUT BUTTON ---
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.go(Routes.login);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  // Adaptive Button Background
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: colorScheme.error, // Adaptive Red
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ColorScheme colorScheme) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surface, // Matches background
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.person, size: 50, color: colorScheme.primary),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.surface, width: 2),
                ),
                child: Icon(Icons.edit, color: colorScheme.onPrimary, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Xyrel D. Tenefrancia",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface, // Adaptive Black
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "xdemocrito1@gmail.com",
          style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color color, // Kept specific colors for icons (Blue/Orange/etc)
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // Use lighter alpha for dark mode so color isn't too muddy
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface, // Adaptive Text
                ),
              ),
            ),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  size: 20,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
      indent: 60,
    );
  }
}
