import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_budget_ph/features/reminders/domains/model/reminder_model.dart';

class ReminderTile extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback onTap;

  const ReminderTile({super.key, required this.reminder, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // --- SMART LOGIC ---
    final daysLeft = reminder.dueDate.difference(DateTime.now()).inDays;
    final isOverdue = daysLeft < 0;
    final isUrgent = daysLeft <= 3 && !isOverdue;

    // Determine Status Colors & Text
    Color statusColor;
    String statusText;

    if (isOverdue) {
      statusColor = colorScheme.error;
      statusText = "Overdue (${daysLeft.abs()} days)";
    } else if (daysLeft == 0) {
      statusColor = Colors.orange;
      statusText = "Due Today";
    } else if (isUrgent) {
      statusColor = Colors.orange;
      statusText = "Due in $daysLeft days";
    } else {
      statusColor = colorScheme.primary;
      statusText = "Due in $daysLeft days";
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            // 1. ICON CONTAINER (Soft Background)
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: reminder.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(reminder.icon, color: reminder.color, size: 24),
            ),
            const SizedBox(width: 16),

            // 2. TITLE & SMART STATUS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Status Dot
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Status Text
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12,
                          color: isOverdue
                              ? statusColor
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isOverdue
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. AMOUNT & DATE
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.simpleCurrency(
                    name: "USD",
                  ).format(reminder.amount),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isOverdue
                        ? colorScheme.error
                        : colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat("MMM d").format(reminder.dueDate),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}
