import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    VoidCallback? onUndo, // Optional Undo action
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    // Determine colors based on type
    final backgroundColor = isError
        ? colorScheme.errorContainer
        : const Color(0xFF1B5E20); // Professional Dark Green

    final textColor = isError ? colorScheme.onErrorContainer : Colors.white;

    final icon = isError
        ? Icons.error_outline_rounded
        : Icons.check_circle_outline_rounded;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating, // Makes it float above bottom
        backgroundColor: backgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16), // Margin from edges
        duration: const Duration(seconds: 3),
        action: onUndo != null
            ? SnackBarAction(
                label: "UNDO",
                textColor: textColor,
                onPressed: onUndo,
              )
            : null,
      ),
    );
  }
}
