import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_budget_ph/core/routes/app_routes.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String _enteredPin = "";
  String _firstPin = "";
  bool _isConfirming = false;

  void _onKeyPressed(String val) {
    if (_enteredPin.length < 4) {
      HapticFeedback.lightImpact();
      setState(() {
        _enteredPin += val;
      });

      if (_enteredPin.length == 4) {
        if (_isConfirming) {
          _validateAndSave();
        } else {
          _switchToConfirmMode();
        }
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

  void _onDeleteLongPressed() {
    if (_enteredPin.isNotEmpty) {
      HapticFeedback.mediumImpact();
      setState(() {
        _enteredPin = "";
      });
    }
  }

  void _switchToConfirmMode() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    setState(() {
      _firstPin = _enteredPin;
      _enteredPin = "";
      _isConfirming = true;
    });
  }

  void _validateAndSave() async {
    if (_enteredPin == _firstPin) {
      HapticFeedback.mediumImpact();
      if (!mounted) return;
      context.go(Routes.home);
    } else {
      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text("PINs do not match. Please try again."),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: const EdgeInsets.all(20),
        ),
      );

      setState(() {
        _enteredPin = "";
        _firstPin = "";
        _isConfirming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isConfirming
                    ? Icons.lock_outline_rounded
                    : Icons.lock_reset_rounded,
                key: ValueKey<bool>(_isConfirming),
                size: 40,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _isConfirming ? "Confirm PIN" : "Create PIN",
                key: ValueKey<bool>(_isConfirming),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _isConfirming
                    ? "Re-enter your PIN to confirm."
                    : "Create a 4-digit PIN.",
                key: ValueKey<bool>(_isConfirming),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isFilled = index < _enteredPin.length;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
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
                children: <Widget>[
                  _buildNumberRow(context, <String>["1", "2", "3"]),
                  const SizedBox(height: 20),
                  _buildNumberRow(context, <String>["4", "5", "6"]),
                  const SizedBox(height: 20),
                  _buildNumberRow(context, <String>["7", "8", "9"]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 75),
                      _buildNumberButton(context, "0"),
                      _buildActionButton(
                        context,
                        icon: Icons.backspace_outlined,
                        onTap: _onDeletePressed,
                        onLongPress: _onDeleteLongPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberRow(BuildContext context, List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numbers
          .map<Widget>((String num) => _buildNumberButton(context, num))
          .toList(),
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
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.3,
          ),
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
    VoidCallback? onLongPress,
  }) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
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
