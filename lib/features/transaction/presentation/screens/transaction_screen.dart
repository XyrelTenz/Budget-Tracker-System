import 'package:flutter/material.dart';
import "package:smart_budget_ph/features/transaction/data/transaction_model.dart";
import "package:smart_budget_ph/features/transaction/presentation/widgets/transaction_item_tile.dart";
import "package:smart_budget_ph/features/transaction/presentation/widgets/transaction_summary_card.dart";
// 1. FIXED: Added the missing import for the SnackBar
import "package:smart_budget_ph/features/transaction/presentation/widgets/add_modal.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import "package:smart_budget_ph/features/transaction/presentation/widgets/snack_bar_widgets.dart";

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _searchQuery = "";
  String _selectedTab = "All";

  // Load data
  final List<TransactionModel> _allTransactions = TransactionModel.dummyData;

  // Logic to Filter Data
  List<TransactionModel> get _filteredTransactions {
    return _allTransactions.where((tx) {
      if (_selectedTab != "All" && tx.type != _selectedTab) return false;
      if (_searchQuery.isEmpty) return true;
      return tx.label.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final groupedTransactions = <String, List<TransactionModel>>{};
    for (var tx in _filteredTransactions) {
      groupedTransactions.putIfAbsent(tx.day, () => []).add(tx);
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Use the package function instead of showModalBottomSheet
          final result = await showMaterialModalBottomSheet(
            context: context,
            expand: false, // false = wrap content height; true = full screen
            enableDrag: true,
            backgroundColor:
                Colors.transparent, // Important: Lets your rounded corners show
            builder: (context) => const AddTransactionModal(),
          );

          // Logic to handle the result remains the same
          if (result == true) {
            if (context.mounted) {
              CustomSnackBar.show(
                context,
                message: "New expense added successfully!",
              );
            }
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Add New"),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Search Bar
                    _buildSearchBar(colorScheme),
                    const SizedBox(height: 20),

                    // Summary Card
                    const TransactionSummaryCard(
                      totalBalance: 12450.00,
                      income: 20000.00,
                      expense: -7550.00,
                    ),
                    const SizedBox(height: 20),

                    // Filter Tabs
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "All",
                          "Income",
                          "Expense",
                        ].map((tab) => _buildTab(tab, colorScheme)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Transaction List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: groupedTransactions.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            "No transactions found",
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final day = groupedTransactions.keys.elementAt(index);
                        final transactions = groupedTransactions[day]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurfaceVariant,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            ...transactions.map(
                              (tx) => TransactionItemTile(transaction: tx),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      }, childCount: groupedTransactions.length),
                    ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme colorScheme) {
    return TextField(
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        hintText: "Search transactions...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        // 3. FIXED: changed .withValues() to .withOpacity() for compatibility
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTab(String text, ColorScheme colorScheme) {
    final isActive = _selectedTab == text;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(text),
        selected: isActive,
        onSelected: (bool selected) {
          setState(() {
            _selectedTab = text;
          });
        },
        selectedColor: colorScheme.primary,
        labelStyle: TextStyle(
          color: isActive ? colorScheme.onPrimary : colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
      ),
    );
  }
}
