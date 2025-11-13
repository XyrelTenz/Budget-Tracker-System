import 'package:budget_tracker/screen/account_screen.dart';
import 'package:budget_tracker/screen/home_screen.dart';
import 'package:budget_tracker/screen/report_screen.dart';
import 'package:budget_tracker/screen/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationWidget> {
  final List<Widget> _homeScreen = <Widget>[
    HomeScreen(),
    TransactionScreen(),
    ReportScreen(),
    AccountScreen(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeScreen[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Color(0xFF313131),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.bar_chart),
    title: const Text("Transaction"),
    selectedColor: Color(0xFF313131),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.money),
    title: const Text("Report"),
    selectedColor: Color(0xFF313131),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Account"),
    selectedColor: Color(0xFF313131),
  ),
];
