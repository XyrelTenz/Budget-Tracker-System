import 'package:flutter/material.dart';
import "package:smart_budget_ph/core/routes/app_routes.dart";
import "package:go_router/go_router.dart";

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Capture Theme
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Adaptive Background
      backgroundColor: colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        // Brand Blue
        backgroundColor: colorScheme.primary,
        elevation: 3,
        shape: const CircleBorder(),
        onPressed: () {
          context.go('${Routes.reminder}/${Routes.set}');
        },
        child: Icon(Icons.add, size: 32, color: colorScheme.onPrimary),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 80,
          ),
          children: [
            _reminderItem(
              title: "Bill Payments",
              amount: "\$200",
              reminderDate: "26 May 2024",
              dueDate: "3 Jun 2024",
              context: context,
            ),
            _reminderItem(
              title: "Car Loan",
              amount: "\$600",
              reminderDate: "26 May 2024",
              dueDate: "11 July 2024",
              context: context,
            ),
            _reminderItem(
              title: "Iphone 15 Pro",
              amount: "\$1,000",
              reminderDate: "26 May 2024",
              dueDate: "3 Aug 2024",
              context: context,
            ),
            _reminderItem(
              title: "New Bike",
              amount: "\$2,300",
              reminderDate: "26 May 2024",
              dueDate: "12 Sep 2024",
              context: context,
            ),
            _reminderItem(
              title: "House Rent",
              amount: "\$1,500",
              reminderDate: "28 May 2024",
              dueDate: "15 Sep 2024",
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _reminderItem({
    required String title,
    required String amount,
    required String reminderDate,
    required String dueDate,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reminder Date: $reminderDate",
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface, // Adaptive Black
                    ),
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            // Right Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.more_horiz, color: colorScheme.onSurfaceVariant),
                const SizedBox(height: 14),
                Text(
                  "Due on\n$dueDate",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        const SizedBox(height: 16),
      ],
    );
  }
}
