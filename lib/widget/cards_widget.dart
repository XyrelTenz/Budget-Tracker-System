import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final bool isSelected;

  const CardItem({
    super.key,
    this.title = "Total Expense",
    this.amount = "\$298.16",
    this.icon = Icons.credit_card,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected ? const Color(0xFF2563EB) : Colors.white;
    final Color textColor = isSelected ? Colors.white : Colors.black87;

    return Container(
      width: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor, size: 30),
          const SizedBox(height: 25),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.9)),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
