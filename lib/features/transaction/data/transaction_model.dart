// features/transaction/data/transaction_model.dart
import 'package:flutter/material.dart';

class TransactionModel {
  final IconData icon;
  final String label;
  final String description;
  final double amount; // Changed to double for math
  final String time;
  final String day;
  final String type; // "Income" or "Expense"

  TransactionModel({
    required this.icon,
    required this.label,
    required this.description,
    required this.amount,
    required this.time,
    required this.day,
    required this.type,
  });

  // Mock Data Repository
  static List<TransactionModel> get dummyData => [
    TransactionModel(
      icon: Icons.fastfood_rounded,
      label: "Jollibee",
      description: "Lunch",
      amount: -120.00,
      time: "11:23 AM",
      day: "Today",
      type: "Expense",
    ),
    TransactionModel(
      icon: Icons.directions_car_rounded,
      label: "Grab Ride",
      description: "Transport",
      amount: -60.00,
      time: "9:40 AM",
      day: "Today",
      type: "Expense",
    ),
    TransactionModel(
      icon: Icons.work_rounded,
      label: "Salary",
      description: "Monthly Salary",
      amount: 25000.00,
      time: "8:00 AM",
      day: "Yesterday",
      type: "Income",
    ),
    TransactionModel(
      icon: Icons.shopping_bag_rounded,
      label: "Grocery",
      description: "Weekly supplies",
      amount: -3500.00,
      time: "6:30 PM",
      day: "Yesterday",
      type: "Expense",
    ),
  ];
}
