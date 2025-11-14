import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor = const Color(0xFF3B82F6),
    this.iconBackgroundColor = const Color(0xFFBAE6FD),
    this.iconColor = const Color(0xFF1F2937),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 55,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 7),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: iconBackgroundColor,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

