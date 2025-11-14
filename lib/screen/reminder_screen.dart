import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f8fb),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Reminders",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add, size: 28),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Stay organized by tracking your important tasks.",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const SizedBox(height: 20),

          // Reminder Cards
          _reminderCard(
            title: "Pay electricity bill",
            date: "Tomorrow • 8:00 AM",
            priorityColor: Colors.redAccent,
            icon: Icons.flash_on,
          ),

          _reminderCard(
            title: "School project submission",
            date: "Nov 20 • 11:59 PM",
            priorityColor: Colors.orangeAccent,
            icon: Icons.school,
          ),

          _reminderCard(
            title: "Buy groceries",
            date: "Nov 16 • 5:00 PM",
            priorityColor: Colors.green,
            icon: Icons.shopping_bag,
          ),

          _reminderCard(
            title: "Drink water & rest",
            date: "Everyday",
            priorityColor: Colors.blueAccent,
            icon: Icons.health_and_safety,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ---------------------------
  // Reminder Card Widget
  // ---------------------------
  Widget _reminderCard({
    required String title,
    required String date,
    required IconData icon,
    required Color priorityColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: priorityColor, size: 28),
          ),

          const SizedBox(width: 16),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
