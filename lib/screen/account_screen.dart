import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f8fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Xyrel D. Tenefrancia",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // QUICK ACTIONS TITLE
              const Text(
                "Quick Actions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // QUICK ACTIONS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _item(Icons.edit, "Edit Profile"),
                    _item(Icons.notifications, "Notifications"),
                    _item(Icons.category, "Manage Categories"),
                    _item(Icons.file_download, "Export Data"),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Settings",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // SETTINGS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _item(Icons.lock, "Security & Privacy"),
                    _item(Icons.key, "Change Password"),
                    _item(Icons.backup, "Backup & Restore"),
                    _toggleItem("Dark Mode"),
                  ],
                ),
              ),

              const Spacer(),

              // LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go("/Login");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// REUSABLE ITEM ROW
Widget _item(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 16),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ],
    ),
  );
}

// TOGGLE ITEM (e.g., Dark Mode)
Widget _toggleItem(String label) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isOn = false;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.dark_mode, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            Switch(value: isOn, onChanged: (val) => setState(() => isOn = val)),
          ],
        ),
      );
    },
  );
}
