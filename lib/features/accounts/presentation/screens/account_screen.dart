import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/routes/app_routes.dart";
import "package:smart_budget_ph/core/theme/theme_provider.dart";

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final currentThemeMode = ref.watch(themeProvider);
    final isDarkMode = currentThemeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildProfileHeader(colorScheme),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                "General",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
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
                    onTap: () {
                      context.go('${Routes.account}/${Routes.editprofile}');
                    },
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    color: Colors.orange,
                    label: "Notifications",
                    onTap: () {
                      context.go(
                        '${Routes.account}/${Routes.notificationsettings}',
                      );
                    },
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.category_outlined,
                    color: Colors.purple,
                    label: "Categories",
                    onTap: () {
                      context.go('${Routes.account}/${Routes.categories}');
                    },
                    colorScheme: colorScheme,
                  ),
                  _buildDivider(colorScheme),
                  _buildMenuItem(
                    icon: Icons.file_download_outlined,
                    color: Colors.teal,
                    label: "Export Data",
                    onTap: () {
                      context.go('${Routes.account}/${Routes.exportdata}');
                    },
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

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
                    onTap: () {
                      context.go('${Routes.account}/${Routes.securityprivacy}');
                    },
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

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.go(Routes.login);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                    color: colorScheme.error,
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
                border: Border.all(color: colorScheme.surface, width: 4),
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
            color: colorScheme.onSurface,
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
    required Color color,
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
                  color: colorScheme.onSurface,
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
