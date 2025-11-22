import 'package:flutter/material.dart';
import 'package:smart_budget_ph/features/reports/domains/entities/time_filter.dart';

class TimeFilterSelector extends StatelessWidget {
  final TimeFilter selectedFilter;
  final ValueChanged<TimeFilter> onFilterChanged;

  const TimeFilterSelector({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<TimeFilter>(
        segments: const [
          ButtonSegment(
            value: TimeFilter.weekly,
            label: Text("Weekly"),
            icon: Icon(Icons.calendar_view_week, size: 18),
          ),
          ButtonSegment(
            value: TimeFilter.monthly,
            label: Text("Monthly"),
            icon: Icon(Icons.calendar_month, size: 18),
          ),
        ],
        selected: {selectedFilter},
        onSelectionChanged: (Set<TimeFilter> newSelection) {
          onFilterChanged(newSelection.first);
        },
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? colorScheme.primary
                : colorScheme.surfaceContainer;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant;
          }),
          side: WidgetStateProperty.all(BorderSide.none),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}
