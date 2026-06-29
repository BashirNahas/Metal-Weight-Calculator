import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String _label(BuildContext context, Metal m) {
    final l10n = context.l10n;
    return switch (m) {
      Metal.copper => l10n.copper,
      Metal.aluminum => l10n.aluminum,
      Metal.iron => l10n.iron,
      Metal.steel => l10n.steel,
      Metal.stainlessSteel => l10n.stainlessSteel,
      Metal.zinc => l10n.zinc,
      Metal.nickel => l10n.nickel,
      Metal.lead => l10n.lead,
      Metal.brass => l10n.brass,
      Metal.titanium => l10n.titanium,
      Metal.gold => l10n.gold,
      Metal.silver => l10n.silver,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.l10n.copper == 'نحاس';

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: isArabic, // keep natural RTL scroll direction
        padding: const EdgeInsets.symmetric(horizontal: 2),
        itemCount: Metal.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (ctx, i) {
          final m = isArabic
              ? Metal.values.reversed.toList()[i]
              : Metal.values[i];
          return _MetalTile(
            metal: m,
            label: _label(ctx, m),
            isSelected: selected == m,
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(m);
            },
          );
        },
      ),
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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 80,
        height: 96,
        decoration: BoxDecoration(
          color: isSelected
              ? metal.accentColor.withValues(alpha: isDark ? 0.22 : 0.12)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? metal.accentColor.withValues(alpha: 0.7)
                : colorScheme.outline.withValues(alpha: 0.35),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: metal.accentColor.withValues(alpha: 0.18),
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
              scale: isSelected ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                metal.icon,
                color: isSelected
                    ? metal.accentColor
                    : colorScheme.outline.withValues(alpha: 0.6),
                size: 26,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: isSelected
                        ? colorScheme.onSurface
                        : colorScheme.outline,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
