import 'package:flutter/material.dart';
import 'package:budget_tracker/model/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        final bool isExpense = transaction.amount < 0;
        final Color accentColor = isExpense
            ? Colors.red.shade600
            : Colors.green.shade600;

        final String formattedAmount =
            "${isExpense ? '-' : '+'}\$${transaction.amount.abs().toStringAsFixed(2)}";

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon Circle
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(transaction.icon, color: accentColor, size: 22),
                ),

                const SizedBox(width: 16),

                // Name + Category/Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${transaction.category} • ${transaction.date}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                // Amount
                Text(
                  formattedAmount,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
