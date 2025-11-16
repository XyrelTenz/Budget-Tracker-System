import 'package:flutter/material.dart';
import 'package:budget_tracker/model/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
          child: Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              final bool isExpense = transaction.amount < 0;
              final Color accentColor = isExpense
                  ? Colors.red.shade600
                  : Colors.green.shade600;
              final String formattedAmount =
                  "${isExpense ? '-' : '+'}\$${transaction.amount.abs().toStringAsFixed(2)}";

              return Card(
                elevation: 1.0,
                margin: const EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(transaction.icon, color: accentColor, size: 22),
                  ),

                  title: Text(
                    transaction.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),

                  subtitle: Text(
                    "${transaction.category} • ${transaction.date}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),

                  trailing: Text(
                    formattedAmount,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
