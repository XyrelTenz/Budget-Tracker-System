import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsSettingsScreen extends ConsumerWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Notifications',
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader(context, "General"),
          _buildSwitchTile(context, "Push Notifications", true),
          _buildSwitchTile(context, "Email Alerts", false),

          const SizedBox(height: 20),
          _buildSectionHeader(context, "Activity"),
          _buildSwitchTile(context, "Budget Exceeded", true),
          _buildSwitchTile(context, "Weekly Report", true),
          _buildSwitchTile(context, "Bill Reminders", true),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(BuildContext context, String title, bool value) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      value: value,
      onChanged: (val) {},
      activeThumbColor: Theme.of(context).colorScheme.primary,
    );
  }
}
