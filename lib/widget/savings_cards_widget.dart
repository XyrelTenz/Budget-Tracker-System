import 'package:flutter/material.dart';

class SavingsCards extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const SavingsCards({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 45,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF0046FF) : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 5)),
          Container(
            height: 30,
            width: 15,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : Color(0xFF313131),
            ),
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF313131),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
