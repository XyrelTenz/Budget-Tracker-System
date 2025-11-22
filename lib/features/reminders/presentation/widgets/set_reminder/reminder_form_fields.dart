import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final DateTime selectedDate;
  final VoidCallback onDateTap;

  const ReminderFormFields({
    super.key,
    required this.titleController,
    required this.selectedDate,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          // Title Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Bill Title",
                      labelStyle: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      hintText: "e.g. Netflix, Rent",
                      hintStyle: TextStyle(color: colorScheme.outline),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            indent: 56,
            color: colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),

          // Date Picker Row
          InkWell(
            onTap: onDateTap,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Due Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat.yMMMd().format(selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
