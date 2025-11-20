import 'package:flutter/material.dart';
import 'package:smart_budget_ph/widget/cards_widget.dart';
import 'package:smart_budget_ph/widget/savings_cards_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> items = [
    {'icon': Icons.savings, 'label': 'Savings', 'isSelected': true},
    {
      'icon': Icons.notifications_active,
      'label': 'Remind',
      'isSelected': false,
    },
    {'icon': Icons.wallet, 'label': 'Budget', 'isSelected': false},
  ];

  List<Map<String, dynamic>> cardDataList = [
    {
      "title": "Total Salary",
      "amount": "P50,000.00",
      "icon": Icons.payments,
      "isSelected": true,
    },
    {
      "title": "Total Expenses",
      "amount": "P32,500.00",
      "icon": Icons.receipt_long,
      "isSelected": false,
    },
    {
      "title": "Remaining",
      "amount": "P17,500.00",
      "icon": Icons.account_balance_wallet,
      "isSelected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF313131),
                        ),
                      ),
                      Text(
                        "Welcome back!",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),

            // --- CARDS LIST ---
            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: cardDataList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  final item = cardDataList[index];
                  return CardItem(
                    title: item["title"],
                    amount: item["amount"],
                    icon: item["icon"],
                    isSelected: item["isSelected"],
                    onTap: () {
                      setState(() {
                        // Set all to false, then selected to true
                        for (var element in cardDataList) {
                          element["isSelected"] = false;
                        }
                        cardDataList[index]["isSelected"] = true;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // --- BOTTOM SHEET CONTAINER ---
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // --- TABS ROW (Responsive) ---
                    Row(
                      children: items.asMap().entries.map((entry) {
                        int idx = entry.key;
                        Map item = entry.value;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: idx == items.length - 1 ? 0 : 10,
                            ),
                            child: SavingsCards(
                              isSelected: item['isSelected'],
                              icon: item['icon'],
                              label: item['label'],
                              onTap: () {
                                setState(() {
                                  for (var element in items) {
                                    element["isSelected"] = false;
                                  }
                                  items[idx]["isSelected"] = true;
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 15),

                    // --- INDICATORS ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIndicator(true),
                        const SizedBox(width: 6),
                        _buildIndicator(false),
                        const SizedBox(width: 6),
                        _buildIndicator(false),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // --- LIST HEADER ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest Entries",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF313131),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                          color: Colors.grey,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // --- TRANSACTIONS LIST ---
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 20),
                        children: [
                          _buildEntry(
                            icon: Icons.fastfood,
                            label: "Food",
                            amount: "+ \$20",
                            vat: "0.5%",
                            date: "20 Feb 2024",
                            method: "Google Pay",
                          ),
                          _buildEntry(
                            icon: Icons.directions_bike,
                            label: "Uber",
                            amount: "- \$18",
                            vat: "0.8%",
                            date: "13 Mar 2024",
                            method: "Cash",
                          ),
                          _buildEntry(
                            icon: Icons.shopping_bag,
                            label: "Shopping",
                            amount: "- \$400",
                            vat: "0.12%",
                            date: "11 Mar 2024",
                            method: "Paytm",
                          ),
                          _buildEntry(
                            icon: Icons.movie,
                            label: "Cinema",
                            amount: "- \$35",
                            vat: "0.2%",
                            date: "10 Mar 2024",
                            method: "Card",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0046FF) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildEntry({
    required IconData icon,
    required String label,
    required String amount,
    required String vat,
    required String date,
    required String method,
  }) {
    bool isExpense = amount.contains('-');
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 24, color: const Color(0xFF313131)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF313131),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isExpense ? Colors.redAccent : Colors.green,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                method,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
