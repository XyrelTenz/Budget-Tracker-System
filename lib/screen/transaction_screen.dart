import 'package:flutter/material.dart';
import "package:smart_budget_ph/helper/transaction_helper.dart";

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
    final groupedTransactions = <String, List<TransactionModel>>{};
    for (var tx in _filteredTransactions) {
      if (!groupedTransactions.containsKey(tx.day)) {
        groupedTransactions[tx.day] = [];
      }
      groupedTransactions[tx.day]!.add(tx);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search transactions...",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
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
                          borderSide: const BorderSide(
                            color: Color(0xFF0046FF),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list),
                      color: const Color(0xFF313131),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0046FF),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0046FF).withValues(alpha: 0.3),
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
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "₱12,450",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                          Colors.greenAccent,
                        ),
                        _buildSummaryItem(
                          "Expense",
                          "₱7,550",
                          Icons.arrow_upward,
                          Colors.redAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab("All"),
                  _buildTab("Income"),
                  _buildTab("Expense"),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: _filteredTransactions.isEmpty
                    ? Center(
                        child: Text(
                          "No transactions found",
                          style: TextStyle(color: Colors.grey.shade400),
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
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF313131),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...entry.value.map((tx) => _transactionItem(tx)),
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
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
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
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String text) {
    bool active = _selectedTab == text;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0046FF) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _transactionItem(TransactionModel tx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tx.icon, color: const Color(0xFF313131)),
          ),
          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF313131),
                  ),
                ),
                Text(
                  tx.description,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ],
            ),
          ),

          // AMOUNT + TIME
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tx.amount > 0 ? "+₱${tx.amount}" : "₱${tx.amount.abs()}",
                style: TextStyle(
                  color: tx.amount > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                tx.time,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
