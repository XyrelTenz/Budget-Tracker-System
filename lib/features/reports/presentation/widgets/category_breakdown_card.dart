import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_budget_ph/features/reports/domains/entities/category_spending.dart';
import 'professional_card.dart';

class CategoryBreakdownCard extends StatefulWidget {
  const CategoryBreakdownCard({super.key});

  @override
  State<CategoryBreakdownCard> createState() => _CategoryBreakdownCardState();
}

class _CategoryBreakdownCardState extends State<CategoryBreakdownCard> {
  int _touchedPieIndex = -1;

  final List<CategorySpending> categoryData = [
    CategorySpending("Food", 6500.50, const Color(0xFF4B68FF)),
    CategorySpending("Transport", 2200.00, const Color(0xFFFF8A4B)),
    CategorySpending("Shopping", 1500.20, const Color(0xFF00D2FF)),
    CategorySpending("Bills", 850.00, const Color(0xFFFF3D00)),
    CategorySpending("Others", 1400.00, const Color(0xFF9C27B0)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    double total = categoryData.fold(0, (sum, item) => sum + item.amount);

    return ProfessionalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Categories",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Row: Pie Chart (Left) + Legend (Right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 30,
                    sections: categoryData.map((item) {
                      final isTouched =
                          categoryData.indexOf(item) == _touchedPieIndex;
                      return PieChartSectionData(
                        color: item.color,
                        value: item.amount,
                        title: "",
                        radius: isTouched ? 50 : 40,
                      );
                    }).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (evt, response) {
                        setState(() {
                          if (response != null &&
                              response.touchedSection != null) {
                            _touchedPieIndex =
                                response.touchedSection!.touchedSectionIndex;
                          } else {
                            _touchedPieIndex = -1;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Biggest Spender",
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Food & Dining",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "52% of total",
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Detailed List
          ...categoryData.map((category) {
            final percentage = (category.amount / total);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.circle, size: 12, color: category.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              NumberFormat.compactCurrency(
                                symbol: "₱",
                              ).format(category.amount),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor:
                                colorScheme.surfaceContainerHighest,
                            color: category.color,
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
