import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/l10n/app_localizations.dart';
import 'package:metal_weight_calculator/models/metal.dart';

class MetalSelector extends StatelessWidget {
  final Metal selected;
  final ValueChanged<Metal> onChanged;

  const MetalSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _primaryMetals = [Metal.copper, Metal.aluminum];

  String _label(AppLocalizations l10n, Metal m) => switch (m) {
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

  void _openSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => _MetalPickerSheet(
        selected: selected,
        labelOf: (m) => _label(l10n, m),
        headerLabel: l10n.selectMetal,
        onPick: (m) {
          HapticFeedback.selectionClick();
          Navigator.pop(ctx);
          onChanged(m);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isArabic = l10n.copper == 'نحاس';
    final isNonPrimary = !_primaryMetals.contains(selected);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // If a non-primary metal is selected, highlight it at the top
        if (isNonPrimary) ...[
          _SelectedMetalBanner(
            metal: selected,
            label: _label(l10n, selected),
            changeLabel: isArabic ? 'تغيير' : 'Change',
            onTap: () => _openSheet(context, l10n),
          ),
          const SizedBox(height: 12),
        ],

        // Primary metals + "More" button
        SizedBox(
          height: 104,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final m in _primaryMetals) ...[
                Expanded(
                  child: _PrimaryMetalCard(
                    metal: m,
                    label: _label(l10n, m),
                    isSelected: selected == m,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onChanged(m);
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
              _MoreMetalsButton(
                moreLabel:
                    isArabic ? 'معادن\nأخرى' : 'More\nMetals',
                swapLabel: isArabic ? 'تغيير' : 'Swap',
                isNonPrimary: isNonPrimary,
                onTap: () => _openSheet(context, l10n),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Primary metal card (shown always) ────────────────────────────────────────

class _PrimaryMetalCard extends StatelessWidget {
  final Metal metal;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PrimaryMetalCard({
    required this.metal,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    metal.accentColor.withValues(alpha: isDark ? 0.38 : 0.20),
                    metal.accentColor.withValues(alpha: isDark ? 0.15 : 0.08),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [colorScheme.surface, colorScheme.surface]
                      : [Colors.white, const Color(0xFFF7F7FB)],
                ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? metal.accentColor.withValues(alpha: 0.65)
                : colorScheme.outline.withValues(alpha: 0.18),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? metal.accentColor.withValues(alpha: isDark ? 0.2 : 0.15)
                  : Colors.black.withValues(alpha: isDark ? 0.14 : 0.05),
              blurRadius: isSelected ? 18 : 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 220),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: metal.accentColor.withValues(
                    alpha: isSelected ? (isDark ? 0.28 : 0.18) : 0.09,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  metal.icon,
                  color: isSelected
                      ? metal.accentColor
                      : metal.accentColor.withValues(alpha: 0.45),
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              const SizedBox(height: 3),
              Text(
                '${metal.density} g/cm³',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: metal.accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 9.5,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── "More metals" trigger button ─────────────────────────────────────────────

class _MoreMetalsButton extends StatelessWidget {
  final String moreLabel;
  final String swapLabel;
  final bool isNonPrimary;
  final VoidCallback onTap;

  const _MoreMetalsButton({
    required this.moreLabel,
    required this.swapLabel,
    required this.isNonPrimary,
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
        width: 76,
        decoration: BoxDecoration(
          color: isNonPrimary
              ? colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.10)
              : (isDark ? colorScheme.surface : const Color(0xFFF4F4F9)),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isNonPrimary
                ? colorScheme.primary.withValues(alpha: 0.45)
                : colorScheme.outline.withValues(alpha: 0.18),
            width: isNonPrimary ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNonPrimary
                  ? Icons.swap_horiz_rounded
                  : Icons.grid_view_rounded,
              color: isNonPrimary
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.38),
              size: 24,
            ),
            const SizedBox(height: 7),
            Text(
              isNonPrimary ? swapLabel : moreLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isNonPrimary
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.45),
                    fontWeight:
                        isNonPrimary ? FontWeight.bold : FontWeight.w500,
                    height: 1.25,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Banner for non-primary selected metal ────────────────────────────────────

class _SelectedMetalBanner extends StatelessWidget {
  final Metal metal;
  final String label;
  final String changeLabel;
  final VoidCallback onTap;

  const _SelectedMetalBanner({
    required this.metal,
    required this.label,
    required this.changeLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              metal.accentColor.withValues(alpha: isDark ? 0.30 : 0.14),
              metal.accentColor.withValues(alpha: isDark ? 0.10 : 0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: metal.accentColor.withValues(alpha: 0.48),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: metal.accentColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(metal.icon, color: metal.accentColor, size: 19),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    '${metal.density} g/cm³',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: metal.accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: metal.accentColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: metal.accentColor.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                changeLabel,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: metal.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Full metal picker bottom sheet ───────────────────────────────────────────

class _MetalPickerSheet extends StatelessWidget {
  final Metal selected;
  final String Function(Metal) labelOf;
  final ValueChanged<Metal> onPick;
  final String headerLabel;

  const _MetalPickerSheet({
    required this.selected,
    required this.labelOf,
    required this.onPick,
    required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (ctx, scrollController) {
        return Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outline.withValues(alpha: 0.28),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      headerLabel,
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ],
              ),
            ),
            // Metal grid
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.90,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: Metal.values.length,
                itemBuilder: (_, i) {
                  final m = Metal.values[i];
                  return _MetalGridCell(
                    metal: m,
                    label: labelOf(m),
                    isSelected: m == selected,
                    onTap: () => onPick(m),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Single cell inside the picker grid ───────────────────────────────────────

class _MetalGridCell extends StatelessWidget {
  final Metal metal;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MetalGridCell({
    required this.metal,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? metal.accentColor.withValues(alpha: isDark ? 0.28 : 0.13)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? metal.accentColor.withValues(alpha: 0.60)
                : colorScheme.outline.withValues(alpha: 0.16),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: metal.accentColor.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: metal.accentColor.withValues(
                  alpha: isSelected ? (isDark ? 0.28 : 0.16) : 0.08,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                metal.icon,
                color: isSelected
                    ? metal.accentColor
                    : metal.accentColor.withValues(alpha: 0.5),
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.65),
                    fontSize: 11.5,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (isSelected) ...[
              const SizedBox(height: 2),
              Text(
                '${metal.density} g/cm³',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: metal.accentColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
