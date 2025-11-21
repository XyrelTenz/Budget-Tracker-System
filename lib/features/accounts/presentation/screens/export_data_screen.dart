import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExportDataScreen extends ConsumerWidget {
  const ExportDataScreen({super.key});

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
          'Export Data',
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Format", style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildChip(context, "PDF Document", true),
                const SizedBox(width: 10),
                _buildChip(context, "Excel (CSV)", false),
              ],
            ),
            const SizedBox(height: 30),
            Text("Date Range", style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Last 30 Days", style: theme.textTheme.bodyMedium),
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text("Download Report"),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (val) {},
      checkmarkColor: isSelected ? colorScheme.onPrimary : null,
      selectedColor: colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
    );
  }
}
