import 'package:flutter/material.dart';

class ReminderModel {
  final String title;
  final double amount;
  final DateTime dueDate;
  final IconData icon;
  final Color color;

  ReminderModel({
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.icon,
    required this.color,
  });
}
