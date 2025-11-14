import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    double totalSpent = 187.44;
    double monthlyIncome = 1000.00;
    double remaining = monthlyIncome - totalSpent;
    // double spentPercent = totalSpent / monthlyIncome;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "\$${remaining.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),

          // --- Chart and Details Row ---
          Row(
            children: [
              // 1. The Donut Chart
              SizedBox(
                width: 100,
                height: 100,
                child: PieChart(
                  PieChartData(
                    // This makes it a donut chart
                    centerSpaceRadius: 35,
                    sectionsSpace: 2,
                    // Turn off the default touch behavior
                    pieTouchData: PieTouchData(enabled: false),
                    // This hides the default titles
                    sections: [
                      // "Spent" section
                      PieChartSectionData(
                        value: totalSpent,
                        color: Colors.redAccent.shade400,
                        radius: 25,
                        showTitle: false,
                      ),
                      // "Remaining" section
                      PieChartSectionData(
                        value: remaining,
                        color: Colors.white.withOpacity(0.2),
                        radius: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 24),

              // 2. The Income/Spent Details
              Expanded(
                child: Column(
                  children: [
                    // Helper widget for Income block
                    _buildIncomeExpenseBlock(
                      context,
                      "Income",
                      "\$${monthlyIncome.toStringAsFixed(2)}",
                      Icons.arrow_upward,
                      Colors.greenAccent.shade400,
                    ),
                    const SizedBox(height: 16),
                    // Helper widget for Spent block
                    _buildIncomeExpenseBlock(
                      context,
                      "Spent",
                      "\$${totalSpent.toStringAsFixed(2)}",
                      Icons.arrow_downward,
                      Colors.redAccent.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget to build the "Income" and "Spent" blocks
  Widget _buildIncomeExpenseBlock(
    BuildContext context,
    String label,
    String amount,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
