import 'package:flutter/material.dart';

class FrequencySelector extends StatelessWidget {
  final String selectedFrequency;
  final ValueChanged<String> onFrequencyChanged;

  const FrequencySelector({
    super.key,
    required this.selectedFrequency,
    required this.onFrequencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Frequency",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: "Weekly", label: Text("Weekly")),
              ButtonSegment(value: "Monthly", label: Text("Monthly")),
              ButtonSegment(value: "Yearly", label: Text("Yearly")),
            ],
            selected: {selectedFrequency},
            onSelectionChanged: (Set<String> newSelection) {
              onFrequencyChanged(newSelection.first);
            },
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.selected)
                    ? colorScheme.secondaryContainer
                    : colorScheme.surfaceContainerLowest;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.selected)
                    ? colorScheme.onSecondaryContainer
                    : colorScheme.onSurface;
              }),
              side: WidgetStateProperty.all(
                BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
