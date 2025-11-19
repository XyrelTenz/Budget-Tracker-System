import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TimeFilter _selectedFilter = TimeFilter.weekly;
  int _touchedPieIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 27),
            _buildTimeFilter(),
            const SizedBox(height: 24),
            _buildWeeklyChartCard(),
            const SizedBox(height: 24),
            _buildCategoryChartCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeFilter() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: SegmentedButton<TimeFilter>(
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
        // Fixed: Replaced MaterialStateProperty with WidgetStateProperty
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF0046FF).withOpacity(0.1);
            }
            return Colors.white;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF0046FF);
            }
            return Colors.grey.shade700;
          }),
          side: WidgetStateProperty.all(BorderSide.none),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyChartCard() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Spending Trend",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF313131),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Last 7 Days",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0046FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "\$458.50",
                  style: TextStyle(
                    color: Color(0xFF0046FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
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
    final List<CategorySpending> categoryData = [
      CategorySpending("Food", 300.50, const Color(0xFF0046FF)),
      CategorySpending("Transport", 120.00, const Color(0xFFFF6B00)),
      CategorySpending("Shopping", 250.20, const Color(0xFF00D2FF)),
      CategorySpending("Bills", 80.00, const Color(0xFFFF3D00)),
    ];

    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Spending by Category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The Pie Chart
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              _touchedPieIndex = -1;
                              return;
                            }
                            _touchedPieIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: List.generate(categoryData.length, (i) {
                        final isTouched = i == _touchedPieIndex;
                        final fontSize = isTouched ? 16.0 : 12.0;
                        final radius = isTouched ? 60.0 : 50.0;
                        final item = categoryData[i];

                        return PieChartSectionData(
                          color: item.color,
                          value: item.amount,
                          title: '${item.amount.toInt()}',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              // The Legend
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categoryData.map((cat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: cat.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              cat.name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }

  BarChartData _buildWeeklyBarChartData() {
    final List<double> weeklyData = [65, 50, 90, 40, 110, 80, 23.5];

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.blueGrey.shade800,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipMargin: 8,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              '\$${rod.toY.round()}',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              );
              final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
              if (value.toInt() < 0 || value.toInt() >= days.length) {
                return const SizedBox();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(days[value.toInt()], style: style),
              );
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
              gradient: const LinearGradient(
                colors: [Color(0xFF0046FF), Color(0xFF6690FF)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 16,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6),
              ),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 120, // Max height background
                color: const Color(0xFFF0F2F5),
              ),
            ),
          ],
        );
      }),
    );
  }
}

enum TimeFilter { weekly, monthly }

class CategorySpending {
  final String name;
  final double amount;
  final Color color;

  CategorySpending(this.name, this.amount, this.color);
}
