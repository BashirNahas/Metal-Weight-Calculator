import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/models/metal.dart';

class ShapeSelector extends StatelessWidget {
  final Shape selected;
  final ValueChanged<Shape> onChanged;

  const ShapeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final shapes = [
      (Shape.rectangle, l10n.rectangle),
      (Shape.circle, l10n.circle),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: shapes
          .map((s) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _ShapeTile(
                  shape: s.$1,
                  label: s.$2,
                  isSelected: selected == s.$1,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onChanged(s.$1);
                  },
                ),
              ))
          .toList(),
    );
  }
}

class _ShapeTile extends StatelessWidget {
  final Shape shape;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ShapeTile({
    required this.shape,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = context.isDark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : AppColors.surfaceLight)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.secondary : AppColors.primary)
                : colorScheme.outline.withValues(alpha: 0.4),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              shape.icon,
              size: 20,
              color: isSelected ? colorScheme.primary : colorScheme.outline,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? colorScheme.onSurface
                        : colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
