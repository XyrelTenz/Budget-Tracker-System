import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_budget_ph/features/reports/domains/entities/time_filter.dart';

class SpendingSummaryCard extends StatelessWidget {
  final double totalSpend;
  final double previousSpend;
  final TimeFilter timeFilter;

  const SpendingSummaryCard({
    super.key,
    required this.totalSpend,
    required this.previousSpend,
    required this.timeFilter,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final difference = totalSpend - previousSpend;
    final percentChange = (difference / previousSpend) * 100;
    final isSaving = difference < 0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Spending",
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            NumberFormat.currency(symbol: "₱").format(totalSpend),
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSaving ? Icons.trending_down : Icons.trending_up,
                  color: colorScheme.onPrimary,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  "${percentChange.abs().toStringAsFixed(1)}% ${isSaving ? 'less' : 'more'} than last ${timeFilter == TimeFilter.weekly ? 'week' : 'month'}",
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
