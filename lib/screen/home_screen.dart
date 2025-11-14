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
    {'icon': Icons.savings, 'label': 'Savings'},
    {'icon': Icons.notifications_active, 'label': 'Remind'},
    {'icon': Icons.wallet, 'label': 'Budget'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─────────────── HEADER ───────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  // Profile avatar
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                ],
              ),
            ),

            // ─────────────── HORIZONTAL CARDS ───────────────
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(width: 20),
                itemBuilder: (context, index) => const CardItem(),
              ),
            ),

            // ─────────────── CATEGORY BUTTONS BOX ───────────────
            Container(
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
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SavingsCards(
                            icon: items[index]['icon'],
                            label: items[index]['label'],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.blue,
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

                  // ─────────────── Latest Entries ───────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Latest Entries",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // LIST SAMPLE
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======== Entry Item ========
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
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 26, color: Colors.black87),
          ),

          const SizedBox(width: 15),

          // Title + date
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
