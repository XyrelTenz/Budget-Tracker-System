import 'package:flutter/material.dart';

class CategoryIconSelector extends StatelessWidget {
  final IconData selectedIcon;
  final ValueChanged<IconData> onIconChanged;

  const CategoryIconSelector({
    super.key,
    required this.selectedIcon,
    required this.onIconChanged,
  });

  static const List<IconData> _icons = [
    Icons.home_work_outlined,
    Icons.wifi,
    Icons.directions_car_filled_outlined,
    Icons.movie_creation_outlined,
    Icons.shopping_bag_outlined,
    Icons.school_outlined,
    Icons.fitness_center,
    Icons.medical_services_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _icons.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final icon = _icons[index];
              final isSelected = icon == selectedIcon;

              return GestureDetector(
                onTap: () => onIconChanged(icon),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerLowest,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outlineVariant.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                    size: 26,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
