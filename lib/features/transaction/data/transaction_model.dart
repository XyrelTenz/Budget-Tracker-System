import "package:flutter/material.dart";

class TransactionModel {
  final IconData icon;
  final String label;
  final String description;
  final int amount;
  final String time;
  final String day;
  final String type;

  TransactionModel({
    required this.icon,
    required this.label,
    required this.description,
    required this.amount,
    required this.time,
    required this.day,
    required this.type,
  });
}
