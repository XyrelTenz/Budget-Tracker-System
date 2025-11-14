import 'package:flutter/material.dart';
import 'package:budget_tracker/model/transaction_model.dart';
// Note: Replace 'your_app_name'

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        bool isExpense = transaction.amount < 0;
        Color amountColor = isExpense ? Colors.red[700]! : Colors.green[700]!;

        String amountSign = isExpense ? "" : "+";
        String amountString =
            "$amountSign\$${transaction.amount.abs().toStringAsFixed(2)}";

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey[200]!),
            ),
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundColor: amountColor.withOpacity(0.1),
              child: Icon(transaction.icon, color: amountColor, size: 20),
            ),
            title: Text(
              transaction.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${transaction.category} • ${transaction.date}"),
            trailing: Text(
              amountString,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: amountColor,
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Show transaction details
            },
          ),
        );
      },
    );
  }
}
