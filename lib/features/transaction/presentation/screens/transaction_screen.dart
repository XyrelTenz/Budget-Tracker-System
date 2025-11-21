import 'package:flutter/material.dart';
import "package:smart_budget_ph/features/transaction/data/transaction_model.dart";

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _searchQuery = "";
  String _selectedTab = "All";

  final List<TransactionModel> _allTransactions = [
    TransactionModel(
      icon: Icons.fastfood,
      label: "Jollibee",
      description: "Lunch",
      amount: -120,
      time: "11:23 AM",
      day: "Today",
      type: "Expense",
    ),
    TransactionModel(
      icon: Icons.directions_car,
      label: "Grab Ride",
      description: "Transport",
      amount: -60,
      time: "9:40 AM",
      day: "Today",
      type: "Expense",
    ),
    TransactionModel(
      icon: Icons.local_cafe,
      label: "Starbucks",
      description: "Coffee",
      amount: -180,
      time: "8:15 AM",
      day: "Today",
      type: "Expense",
    ),
    TransactionModel(
      icon: Icons.attach_money,
      label: "Salary",
      description: "Company Salary",
      amount: 12000,
      time: "4:11 PM",
      day: "Yesterday",
      type: "Income",
    ),
    TransactionModel(
      icon: Icons.shopping_bag,
      label: "Grocery",
      description: "Weekly supplies",
      amount: -3500,
      time: "6:30 PM",
      day: "Yesterday",
      type: "Expense",
    ),
  ];

  // Filter Logic
  List<TransactionModel> get _filteredTransactions {
    return _allTransactions.where((tx) {
      if (_selectedTab != "All" && tx.type != _selectedTab) return false;

      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return tx.label.toLowerCase().contains(query) ||
          tx.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Capture Theme
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final groupedTransactions = <String, List<TransactionModel>>{};
    for (var tx in _filteredTransactions) {
      if (!groupedTransactions.containsKey(tx.day)) {
        groupedTransactions[tx.day] = [];
      }
      groupedTransactions[tx.day]!.add(tx);
    }

    return Scaffold(
      // Adaptive Background
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SEARCH & FILTER ---
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: colorScheme.onSurface),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search transactions...",
                        hintStyle: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        // Adaptive Search Fill
                        fillColor: colorScheme.surfaceContainerLowest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list),
                      color: colorScheme.onSurfaceVariant,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- TOTAL BALANCE CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // Brand Blue
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balances",
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₱12,450",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryItem(
                          "Income",
                          "₱20,000",
                          Icons.arrow_downward,
                          Colors.greenAccent, // Keep accents distinct
                          colorScheme,
                        ),
                        _buildSummaryItem(
                          "Expense",
                          "₱7,550",
                          Icons.arrow_upward,
                          Colors.redAccent, // Keep accents distinct
                          colorScheme,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- TABS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab("All", colorScheme),
                  _buildTab("Income", colorScheme),
                  _buildTab("Expense", colorScheme),
                ],
              ),

              const SizedBox(height: 20),

              // --- TRANSACTION LIST ---
              Expanded(
                child: _filteredTransactions.isEmpty
                    ? Center(
                        child: Text(
                          "No transactions found",
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.only(bottom: 20),
                        children: groupedTransactions.entries.map((entry) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      colorScheme.onSurface, // Adaptive Black
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...entry.value.map(
                                (tx) => _transactionItem(tx, colorScheme),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String amount,
    IconData icon,
    Color color,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colorScheme.onPrimary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: colorScheme.onPrimary.withValues(alpha: 0.8),
                fontSize: 12,
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String text, ColorScheme colorScheme) {
    bool active = _selectedTab == text;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          // Active: Blue, Inactive: Light Grey (or Dark Grey)
          color: active
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            // Active: White, Inactive: Grey
            color: active
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _transactionItem(TransactionModel tx, ColorScheme colorScheme) {
    bool isExpense = tx.amount < 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        // Adaptive Card Background
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03), // Subtle shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // Icon Background
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tx.icon, color: colorScheme.onSurface),
          ),
          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  tx.description,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // AMOUNT + TIME
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isExpense ? "-\$${tx.amount.abs()}" : "+\$${tx.amount}",
                style: TextStyle(
                  color: isExpense ? colorScheme.error : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                tx.time,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
