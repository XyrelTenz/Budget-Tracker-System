import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_budget_ph/core/routes/app_routes.dart';
import 'package:smart_budget_ph/features/reminders/domains/model/reminder_model.dart';
import 'package:smart_budget_ph/features/reminders/presentation/widgets/reminder_tile.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final reminders = [
      ReminderModel(
        title: "Car Loan",
        amount: 600,
        dueDate: DateTime.now().add(const Duration(days: 2)),
        icon: Icons.directions_car,
        color: Colors.blue,
      ),
      ReminderModel(
        title: "House Rent",
        amount: 1500,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        icon: Icons.home,
        color: Colors.orange,
      ),
      ReminderModel(
        title: "Netflix",
        amount: 15,
        dueDate: DateTime.now().subtract(const Duration(days: 1)),
        icon: Icons.movie,
        color: Colors.red,
      ), // Overdue example
    ];

    return Scaffold(
      backgroundColor: colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => context.go('${Routes.reminder}/${Routes.set}'),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ReminderTile(reminder: reminders[index], onTap: () {});
                }, childCount: reminders.length),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
