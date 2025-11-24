import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_budget_ph/core/routes/app_routes.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String _enteredPin = "";

  void _onKeyPressed(String val) {
    if (_enteredPin.length < 4) {
      HapticFeedback.lightImpact();
      setState(() {
        _enteredPin += val;
      });

      if (_enteredPin.length == 4) {
        _verifyPin();
      }
    }
  }

  void _onDeletePressed() {
    if (_enteredPin.isNotEmpty) {
      HapticFeedback.lightImpact();
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  Future<void> _onBiometricPressed() async {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context);
  }

  Future<void> _verifyPin() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (_enteredPin == "1234") {
      context.go(Routes.home);
    } else {
      setState(() {
        _enteredPin = "";
      });

      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text("Incorrect PIN. Try again."),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: const EdgeInsets.all(20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Icon(
              Icons.lock_outline_rounded,
              size: 40,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              "Enter PIN Code",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Please enter your 4-digit PIN.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isFilled = index < _enteredPin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    border: isFilled
                        ? null
                        : Border.all(
                            color: colorScheme.outlineVariant,
                            width: 1,
                          ),
                  ),
                );
              }),
            ),
            const Spacer(flex: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  _buildNumberRow(context, ["1", "2", "3"]),
                  const SizedBox(height: 20),
                  _buildNumberRow(context, ["4", "5", "6"]),
                  const SizedBox(height: 20),
                  _buildNumberRow(context, ["7", "8", "9"]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.fingerprint,
                        onTap: _onBiometricPressed,
                      ),
                      _buildNumberButton(context, "0"),
                      _buildActionButton(
                        context,
                        icon: Icons.backspace_outlined,
                        onTap: _onDeletePressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1),
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot PIN? Logout",
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberRow(BuildContext context, List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numbers.map((num) => _buildNumberButton(context, num)).toList(),
    );
  }

  Widget _buildNumberButton(BuildContext context, String number) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _onKeyPressed(number),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 75,
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        ),
        child: Text(
          number,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 75,
        height: 75,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 28,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
