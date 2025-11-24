import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/routes/app_routes.dart";

class SecurityPrivacyScreen extends ConsumerWidget {
  const SecurityPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Security & Privacy',
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSecurityItem(
            context,
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              context.go(
                "${Routes.account}/${Routes.securityprivacy}/${Routes.changepassword}",
              );
            },
          ),
          _buildSecurityItem(
            context,
            icon: Icons.fingerprint,
            title: "Biometric Login",
            trailing: Switch(value: true, onChanged: (val) {}),
            onTap: () {},
          ),
          _buildSecurityItem(
            context,
            icon: Icons.devices,
            title: "Manage Devices",
            onTap: () {
              context.go(
                "${Routes.account}/${Routes.securityprivacy}/${Routes.managdevices}",
              );
            },
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: colorScheme.errorContainer.withValues(
                alpha: 0.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.delete_forever),
                SizedBox(width: 8),
                Text(
                  "Delete Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: colorScheme.onSurfaceVariant),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: trailing ?? const Icon(Icons.chevron_right),
    );
  }
}
