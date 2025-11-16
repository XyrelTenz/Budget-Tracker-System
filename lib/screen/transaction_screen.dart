import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CUSTOM HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SUMMARY CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Balance",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "₱12,450",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Income: ₱20,000",
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        Text(
                          "Expense: ₱7,550",
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // TABS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab("All", true),
                  _buildTab("Income", false),
                  _buildTab("Expense", false),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _transactionItem(
                      icon: Icons.fastfood,
                      label: "Jollibee",
                      description: "Lunch",
                      amount: -120,
                      date: "11:23 AM",
                    ),
                    _transactionItem(
                      icon: Icons.directions_car,
                      label: "Grab Ride",
                      description: "Transport",
                      amount: -60,
                      date: "9:40 AM",
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Yesterday",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _transactionItem(
                      icon: Icons.attach_money,
                      label: "Salary",
                      description: "Company Salary",
                      amount: 12000,
                      date: "4:11 PM",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.add),
      //   onPressed: () {},
      // ),
    );
  }
}

Widget _buildTab(String text, bool active) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    decoration: BoxDecoration(
      color: active ? Colors.blue : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: active ? Colors.white : Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _transactionItem({
  required IconData icon,
  required String label,
  required String description,
  required int amount,
  required String date,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(width: 12),

        // TEXT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(description, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),

        // AMOUNT + DATE
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount > 0 ? "+₱$amount" : "₱$amount",
              style: TextStyle(
                color: amount > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(date, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}
