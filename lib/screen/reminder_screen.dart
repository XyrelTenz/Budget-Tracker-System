import 'package:flutter/material.dart';
import "package:smart_budget_ph/components/set_reminder_components.dart";

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0046FF),
        elevation: 3,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SetReminderScreen()),
          );
        },
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25,
            bottom: 80,
          ),
          children: [
            reminderItem(
              title: "Bill Payments",
              amount: "\$200",
              reminderDate: "26 May 2024",
              dueDate: "3 Jun 2024",
            ),
            reminderItem(
              title: "Car Loan",
              amount: "\$600",
              reminderDate: "26 May 2024",
              dueDate: "11 July 2024",
            ),
            reminderItem(
              title: "Iphone 15 Pro",
              amount: "\$1,000",
              reminderDate: "26 May 2024",
              dueDate: "3 Aug 2024",
            ),
            reminderItem(
              title: "New Bike",
              amount: "\$2,300",
              reminderDate: "26 May 2024",
              dueDate: "12 Sep 2024",
            ),
            reminderItem(
              title: "House Rent",
              amount: "\$1,500",
              reminderDate: "28 May 2024",
              dueDate: "15 Sep 2024",
            ),
          ],
        ),
      ),
    );
  }

  Widget reminderItem({
    required String title,
    required String amount,
    required String reminderDate,
    required String dueDate,
  }) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reminder Date: $reminderDate",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    amount,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Right Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.more_horiz, color: Colors.black45),
                const SizedBox(height: 14),
                Text(
                  "Due on\n$dueDate",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(height: 1, color: Colors.black12),
      ],
    );
  }
}
