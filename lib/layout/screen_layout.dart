import "package:flutter/material.dart";
import "../widget/navigation_widget.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("hello"))),
      bottomNavigationBar: NavigationWidget(),
    );
  }
}
