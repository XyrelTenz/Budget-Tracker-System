import 'package:flutter/material.dart';
import 'package:budget_tracker/widget/cards_widget.dart';
import 'package:budget_tracker/widget/savings_cards_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.savings, 'label': 'Savings', 'isSelected': true},
    {
      'icon': Icons.notifications_active,
      'label': 'Remind',
      'isSelected': false,
    },
    {'icon': Icons.wallet, 'label': 'Budget', 'isSelected': false},
  ];

  final List<Map<String, dynamic>> cardDataList = [
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
      "title": "Remaining Balance",
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                itemCount: cardDataList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  final item = cardDataList[index];
                  return CardItem(
                    title: item["title"],
                    amount: item["amount"],
                    icon: item["icon"],
                    isSelected: item["isSelected"],
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: items.map((item) {
                          bool isLastItem = item == items.last;
                          return Padding(
                            padding: EdgeInsets.only(
                              right: isLastItem ? 0 : 12,
                            ),
                            child: SavingsCards(
                              isSelected: item['isSelected'],
                              icon: item['icon'],
                              label: item['label'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Color(0xFF0046FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 12,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 12,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Entries",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadiusDirectional.circular(5),
                            ),
                            child: Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
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
                            method: "Credit Card",
                          ),
                          _buildEntry(
                            icon: Icons.lightbulb,
                            label: "Electricity Bill",
                            amount: "- \$150",
                            vat: "1.2%",
                            date: "08 Mar 2024",
                            method: "Bank Transfer",
                          ),
                          _buildEntry(
                            icon: Icons.local_gas_station,
                            label: "Gas",
                            amount: "- \$55",
                            vat: "0.5%",
                            date: "07 Mar 2024",
                            method: "Cash",
                          ),
                          _buildEntry(
                            icon: Icons.subscriptions,
                            label: "Netflix",
                            amount: "- \$15",
                            vat: "0.0%",
                            date: "05 Mar 2024",
                            method: "Google Pay",
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

  Widget _buildEntry({
    required IconData icon,
    required String label,
    required String amount,
    required String vat,
    required String date,
    required String method,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 26, color: Colors.black87),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$amount + Vat $vat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: amount.contains('-') ? Colors.red : Colors.green,
                  fontSize: 15,
                ),
              ),
              Text(
                method,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
