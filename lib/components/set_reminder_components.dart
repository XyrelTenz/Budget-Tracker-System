import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  String selectedBill = "Car Nhan";
  String? frequency;
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController(
    text: "12,000",
  );

  final List<String> bills = ["Car", "Iphone 15 Pro", "House", "Shopping"];

  final List<String> freqList = ["Daily", "Weekly", "Monthly", "Yearly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF313131)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Set Reminders",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF313131),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _dropdownField(
            label: "Select Bill",
            value: selectedBill,
            onTap: () => _showBillSelection(context),
          ),

          _textField(label: "Amount", controller: amountController),

          _dropdownField(
            label: "Frequency",
            value: frequency ?? "Select One",
            onTap: () => _showFrequency(context),
          ),

          _dateField(context),

          const SizedBox(height: 40),

          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF0046FF),
            ),
            child: const Center(
              child: Text(
                "SET REMINDER",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // UI Widgets
  // ---------------------------

  Widget _dropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }

  Widget _dateField(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // BOTTOM SHEETS
  // ---------------------------

  void _showBillSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: bills.map((bill) {
          return ListTile(
            title: Text(bill),
            trailing: bill == selectedBill
                ? const Icon(Icons.check_circle, color: Color(0xFF0046FF))
                : null,
            onTap: () {
              setState(() => selectedBill = bill);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  void _showFrequency(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: freqList.map((f) {
          return ListTile(
            title: Text(f),
            onTap: () {
              setState(() => frequency = f);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          initialDateTime: selectedDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (date) {
            setState(() => selectedDate = date);
          },
        ),
      ),
    );
  }
}
