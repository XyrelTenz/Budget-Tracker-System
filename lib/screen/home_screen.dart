import "package:flutter/material.dart";

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
      body: SafeArea(child: Column(children: [Cards()])),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
