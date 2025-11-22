// features/transaction/presentation/widgets/transaction_summary_card.dart
import 'package:flutter/material.dart';

class TransactionSummaryCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expense;

  const TransactionSummaryCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Balance",
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onPrimary.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "₱${totalBalance.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                context,
                "Income",
                income,
                Icons.arrow_downward,
                Colors.greenAccent,
              ),
              _buildStatItem(
                context,
                "Expense",
                expense,
                Icons.arrow_upward,
                Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    double value,
    IconData icon,
    Color color,
  ) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: onPrimary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: onPrimary.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
            Text(
              "₱${value.abs().toStringAsFixed(0)}",
              style: TextStyle(
                color: onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
