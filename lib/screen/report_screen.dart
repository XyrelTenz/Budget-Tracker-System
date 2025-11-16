import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TimeFilter _selectedFilter = TimeFilter.weekly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f8fb),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 20),

          _buildTimeFilter(),

          const SizedBox(height: 24),

          _buildWeeklyChartCard(),

          const SizedBox(height: 24),

          _buildCategoryChartCard(),
        ],
      ),
    );
  }

  Widget _buildTimeFilter() {
    return SegmentedButton<TimeFilter>(
      segments: const [
        ButtonSegment(
          value: TimeFilter.weekly,
          label: Text("Weekly"),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment(
          value: TimeFilter.monthly,
          label: Text("Monthly"),
          icon: Icon(Icons.calendar_month),
        ),
      ],
      selected: {_selectedFilter},
      onSelectionChanged: (Set<TimeFilter> newSelection) {
        setState(() {
          _selectedFilter = newSelection.first;
        });
      },
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.white,
        selectedBackgroundColor: Colors.blue.shade50,
        selectedForegroundColor: Colors.blue.shade800,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }

  Widget _buildWeeklyChartCard() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Spending - Last 7 Days",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            "Total: \$458.50",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 220,
            child: BarChart(
              _buildWeeklyBarChartData(),
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChartCard() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Spending by Category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 260,
            child: BarChart(
              _buildCategoryBarChartData(),
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // CARD TEMPLATE (GLASS UI STYLE)
  // -----------------------------------------------------

  Widget _glassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  // -----------------------------------------------------
  // WEEKLY BAR CHART DATA
  // -----------------------------------------------------

  BarChartData _buildWeeklyBarChartData() {
    final List<double> weeklyData = [65, 50, 90, 40, 110, 80, 23.5];

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),

      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(color: Colors.black54, fontSize: 13);
              final days = ["M", "T", "W", "T", "F", "S", "S"];
              if (value.toInt() < 0 || value.toInt() > 6) {
                return const SizedBox();
              }
              return Text(days[value.toInt()], style: style);
            },
          ),
        ),
      ),

      barGroups: List.generate(weeklyData.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: weeklyData[index],
              color: Colors.blue.shade600,
              width: 22,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ],
        );
      }),
    );
  }

  // -----------------------------------------------------
  // CATEGORY BAR CHART
  // -----------------------------------------------------

  BarChartData _buildCategoryBarChartData() {
    final List<CategorySpending> categoryData = [
      CategorySpending("Food", 300.50, Colors.orange.shade600),
      CategorySpending("Transport", 120.00, Colors.purple.shade600),
      CategorySpending("Shopping", 250.20, Colors.teal.shade600),
      CategorySpending("Bills", 80.00, Colors.red.shade600),
    ];

    return BarChartData(
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),

      titlesData: FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 90,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if (index < 0 || index >= categoryData.length) {
                return const SizedBox();
              }
              return Text(
                categoryData[index].name,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              );
            },
          ),
        ),
      ),

      barGroups: List.generate(categoryData.length, (index) {
        final ca = categoryData[index];
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: ca.amount,
              color: ca.color,
              width: 16,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// -----------------------------------------------------

enum TimeFilter { weekly, monthly }

class CategorySpending {
  final String name;
  final double amount;
  final Color color;

  CategorySpending(this.name, this.amount, this.color);
}
