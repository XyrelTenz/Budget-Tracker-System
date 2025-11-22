import 'package:flutter/material.dart';

class AmountInputSection extends StatelessWidget {
  final TextEditingController controller;

  const AmountInputSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          "How much is the bill?",
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        IntrinsicWidth(
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
              height: 1.2,
            ),
            decoration: InputDecoration(
              prefixText: "\$",
              prefixStyle: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary.withValues(alpha: 0.5),
              ),
              hintText: "0",
              hintStyle: TextStyle(color: colorScheme.surfaceContainerHighest),
              border: InputBorder.none,
            ),
            autofocus: true,
          ),
        ),
      ],
    );
  }
}
