import "package:flutter/material.dart";
import 'package:budget_tracker/data/mock_data.dart';
import "package:budget_tracker/widget/summary_card_widget.dart";
import "package:budget_tracker/widget/transaction_list_widget.dart";

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SummaryCard(), // This will be our new header
            // Expanded list
            Expanded(child: TransactionList(transactions: mockTransactions)),
          ],
        ),
      ),
    );
  }
}
