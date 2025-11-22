import 'package:flutter/material.dart';
import 'package:smart_budget_ph/features/reports/domains/entities/time_filter.dart';

// Widgets
import '../widgets/time_filter_selector.dart';
import '../widgets/spending_summary_card.dart';
import '../widgets/spending_trend_chart.dart';
import '../widgets/category_breakdown_card.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TimeFilter _selectedFilter = TimeFilter.weekly;

  final double totalSpend = 12450.50;
  final double previousSpend = 14000.00;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            // Time Filter
            TimeFilterSelector(
              selectedFilter: _selectedFilter,
              onFilterChanged: (newFilter) {
                setState(() => _selectedFilter = newFilter);
              },
            ),
            const SizedBox(height: 20),

            // Summary Card
            SpendingSummaryCard(
              totalSpend: totalSpend,
              previousSpend: previousSpend,
              timeFilter: _selectedFilter,
            ),
            const SizedBox(height: 24),

            // Trends Chart
            SpendingTrendChart(timeFilter: _selectedFilter),
            const SizedBox(height: 24),

            // Category Breakdown
            const CategoryBreakdownCard(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
