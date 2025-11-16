import 'package:flutter/material.dart';

// Transaction Model
class Transaction {
  final String name;
  final String category;
  final String date;
  final double amount;
  final IconData icon;

  const Transaction({
    required this.name,
    required this.category,
    required this.date,
    required this.amount,
    required this.icon,
  });
}
