import 'package:flutter/material.dart';
import 'package:budget_tracker/model/transaction_model.dart';

final List<Transaction> mockTransactions = const [
  Transaction(
    name: "Salary",
    category: "Income",
    date: "Nov 14",
    amount: 2500.00,
    icon: Icons.attach_money,
  ),
  Transaction(
    name: "Coffee Shop",
    category: "Food",
    date: "Nov 14",
    amount: -5.75,
    icon: Icons.local_cafe,
  ),
  Transaction(
    name: "Netflix Subscription",
    category: "Entertainment",
    date: "Nov 13",
    amount: -15.99,
    icon: Icons.movie,
  ),
  Transaction(
    name: "Groceries",
    category: "Food",
    date: "Nov 12",
    amount: -120.50,
    icon: Icons.shopping_cart,
  ),
  Transaction(
    name: "Gas",
    category: "Transport",
    date: "Nov 11",
    amount: -45.20,
    icon: Icons.directions_car,
  ),
  Transaction(
    name: "Freelance Gig",
    category: "Income",
    date: "Nov 10",
    amount: 350.00,
    icon: Icons.work,
  ),
];
