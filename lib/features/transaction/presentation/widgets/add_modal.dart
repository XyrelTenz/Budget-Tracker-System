import 'package:flutter/material.dart';

class AddTransactionModal extends StatefulWidget {
  const AddTransactionModal({super.key});

  @override
  State<AddTransactionModal> createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = "Expense"; // Default

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Check for keyboard visibility to adjust padding
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: double.infinity, // Fill height for scrollable content
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          // 1. Drag Handle (Visual cue)
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // 2. The Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 0, 24, keyboardSpace + 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Transaction",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Type Selector (Income / Expense)
                  Row(
                    children: [
                      Expanded(child: _buildTypeButton("Expense", colorScheme)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTypeButton("Income", colorScheme)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Amount Input
                  Text(
                    "Amount",
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      prefixText: "₱ ",
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest
                          .withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Input
                  Text(
                    "Description",
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: "e.g. Jollibee Lunch",
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest
                          .withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      onPressed: () {
                        // Close modal and return true (indicating success)
                        Navigator.pop(context, true);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Save Transaction",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String type, ColorScheme colorScheme) {
    final isSelected = _selectedType == type;
    final isExpense = type == "Expense";
    final activeColor = isExpense ? colorScheme.error : Colors.green;

    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.1)
              : colorScheme.surfaceContainerHighest.withOpacity(0.3),
          border: Border.all(
            color: isSelected ? activeColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? activeColor : colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
