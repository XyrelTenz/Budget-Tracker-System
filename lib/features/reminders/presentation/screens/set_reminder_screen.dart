import 'package:flutter/material.dart';
import "../widgets/set_reminder/ammount_input_section.dart";
import "../widgets/set_reminder/category_icon_selector.dart";
import "../widgets/set_reminder/frequency_selectory.dart";
import "../widgets/set_reminder/reminder_form_fields.dart";

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 30));
  String _selectedFrequency = "Monthly";
  IconData _selectedIcon = Icons.home_work_outlined;

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  AmountInputSection(controller: _amountController),
                  const SizedBox(height: 32),

                  CategoryIconSelector(
                    selectedIcon: _selectedIcon,
                    onIconChanged: (icon) =>
                        setState(() => _selectedIcon = icon),
                  ),
                  const SizedBox(height: 24),

                  ReminderFormFields(
                    titleController: _titleController,
                    selectedDate: _selectedDate,
                    onDateTap: _pickDate,
                  ),
                  const SizedBox(height: 24),

                  FrequencySelector(
                    selectedFrequency: _selectedFrequency,
                    onFrequencyChanged: (freq) =>
                        setState(() => _selectedFrequency = freq),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: colorScheme.primary,
                  ),
                  child: const Text(
                    "Set Reminder",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
