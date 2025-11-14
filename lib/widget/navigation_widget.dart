import 'package:budget_tracker/screen/account_screen.dart';
import 'package:budget_tracker/screen/home_screen.dart';
import 'package:budget_tracker/screen/report_screen.dart';
import 'package:budget_tracker/screen/transaction_screen.dart';
import 'package:flutter/material.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationWidget> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const TransactionScreen(),
    const ReportScreen(),
    const AccountScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: const Color(0x1A2563EB)),

        child: NavigationBar(
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          destinations: _navBarItems,
        ),
      ),
    );
  }
}

const _navBarItems = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined, color: Color(0xFF313131)),
    selectedIcon: Icon(Icons.home_rounded, color: Colors.blue),
    label: 'Overview',
  ),
  NavigationDestination(
    icon: Icon(Icons.receipt_long_outlined, color: Color(0xFF313131)),
    selectedIcon: Icon(Icons.receipt_long, color: Colors.blue),
    label: 'Transactions',
  ),
  NavigationDestination(
    icon: Icon(Icons.bar_chart_outlined, color: Color(0xFF313131)),
    selectedIcon: Icon(Icons.bar_chart_rounded, color: Colors.blue),
    label: 'Reports',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline_rounded, color: Color(0xFF313131)),
    selectedIcon: Icon(Icons.person_rounded, color: Colors.blue),
    label: 'Account',
  ),
];
