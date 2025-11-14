import 'package:flutter/material.dart';

class SavingsCards extends StatelessWidget {
  final IconData icon;
  final String label;

  const SavingsCards({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 7),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, size: 20, color: Color(0xFF313131)),
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF313131),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

