import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/models/metal.dart';

class MetalSelector extends StatelessWidget {
  final Metal selected;
  final ValueChanged<Metal> onChanged;

  const MetalSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final metals = [
      (Metal.copper, l10n.copper),
      (Metal.aluminum, l10n.aluminum),
      (Metal.iron, l10n.iron),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: metals
          .map((m) => _MetalTile(
                metal: m.$1,
                label: m.$2,
                isSelected: selected == m.$1,
                onTap: () {
                  HapticFeedback.selectionClick();
                  onChanged(m.$1);
                },
              ))
          .toList(),
    );
  }
}

class _MetalTile extends StatelessWidget {
  final Metal metal;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MetalTile({
    required this.metal,
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
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : AppColors.surfaceLight)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.secondary : AppColors.primary)
                : colorScheme.outline.withValues(alpha: 0.4),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 220),
              child: Icon(
                metal.icon,
                color: isSelected ? metal.accentColor : colorScheme.outline,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? colorScheme.onSurface
                        : colorScheme.outline,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
