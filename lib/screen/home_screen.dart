import 'package:budget_tracker/widget/savings_cards_widget.dart';
import 'package:flutter/material.dart';
import "package:budget_tracker/widget/cards_widget.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Map<String, dynamic>> items = [
  {'icon': Icons.savings, 'label': 'Savings'},
  {'icon': Icons.shopping_cart, 'label': 'Shopping'},
  {'icon': Icons.fastfood, 'label': 'Food'},
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 20),
              child: Text(
                "Xyrels",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(width: 25),
                itemBuilder: (context, index) => const CardItem(),
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(35.0),
                      child: SizedBox(
                        height: 45,
                        child: PageView(
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: SavingsCards(
                                    icon: items[index]['icon'],
                                    label: items[index]['label'],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
}
