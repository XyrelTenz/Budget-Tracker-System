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
          colors: <Color>[Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
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

          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 35,
                    sectionsSpace: 2,
                    pieTouchData: PieTouchData(enabled: false),
                    sections: <PieChartSectionData>[
                      PieChartSectionData(
                        value: totalSpent,
                        color: Colors.redAccent.shade400,
                        radius: 25,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: remaining,
                        color: Colors.white.withValues(alpha: 0.2),
                        radius: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: Column(
                  children: <Widget>[
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

  Widget _buildIncomeExpenseBlock(
    BuildContext context,
    String label,
    String amount,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
