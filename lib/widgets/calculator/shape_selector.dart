import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/l10n/app_localizations.dart';
import 'package:metal_weight_calculator/models/metal.dart';

class ShapeSelector extends StatelessWidget {
  final Shape selected;
  final ValueChanged<Shape> onChanged;

  const ShapeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _primaryShapes = [Shape.rectangle, Shape.circle];

  String _label(AppLocalizations l10n, Shape s) => l10n.shapeLabel(s);

  void _openSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => _ShapePickerSheet(
        selected: selected,
        labelOf: (s) => _label(l10n, s),
        headerLabel: l10n.selectShape,
        onPick: (s) {
          HapticFeedback.selectionClick();
          Navigator.pop(ctx);
          onChanged(s);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isNonPrimary = !_primaryShapes.contains(selected);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Banner for non-primary selection
        if (isNonPrimary) ...[
          _SelectedShapeBanner(
            shape: selected,
            label: _label(l10n, selected),
            changeLabel: l10n.changeLabel,
            onTap: () => _openSheet(context, l10n),
          ),
          const SizedBox(height: 10),
        ],

        // Primary shapes + more button
        SizedBox(
          height: 56,
          child: Row(
            children: [
              for (final s in _primaryShapes) ...[
                Expanded(
                  child: _ShapeTile(
                    shape: s,
                    label: _label(l10n, s),
                    isSelected: selected == s,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onChanged(s);
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
              _MoreShapesButton(
                label: l10n.moreShapes,
                changeLabel: l10n.changeLabel,
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

// ─── Primary shape tile ────────────────────────────────────────────────────────

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.10)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.secondary : AppColors.primary)
                    .withValues(alpha: 0.8)
                : colorScheme.outline.withValues(alpha: 0.22),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              shape.icon,
              size: 18,
              color: isSelected ? colorScheme.primary : colorScheme.outline,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  label,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.onSurface
                            : colorScheme.outline,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── "More shapes" button ──────────────────────────────────────────────────────

class _MoreShapesButton extends StatelessWidget {
  final String label;
  final String changeLabel;
  final bool isNonPrimary;
  final VoidCallback onTap;

  const _MoreShapesButton({
    required this.label,
    required this.changeLabel,
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
        height: double.infinity,
        decoration: BoxDecoration(
          color: isNonPrimary
              ? colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.10)
              : (isDark ? colorScheme.surface : const Color(0xFFF4F4F9)),
          borderRadius: BorderRadius.circular(14),
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
              isNonPrimary ? Icons.swap_horiz_rounded : Icons.widgets_outlined,
              color: isNonPrimary
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.38),
              size: 20,
            ),
            const SizedBox(height: 3),
            Text(
              isNonPrimary ? changeLabel : label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isNonPrimary
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.45),
                    fontWeight:
                        isNonPrimary ? FontWeight.bold : FontWeight.w500,
                    height: 1.2,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Banner when a non-primary shape is selected ───────────────────────────────

class _SelectedShapeBanner extends StatelessWidget {
  final Shape shape;
  final String label;
  final String changeLabel;
  final VoidCallback onTap;

  const _SelectedShapeBanner({
    required this.shape,
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: isDark ? 0.28 : 0.12),
              AppColors.secondary.withValues(alpha: isDark ? 0.10 : 0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.45),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                shape.icon,
                color: colorScheme.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  label,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                changeLabel,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
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

// ─── Bottom sheet with all shapes ─────────────────────────────────────────────

class _ShapePickerSheet extends StatelessWidget {
  final Shape selected;
  final String Function(Shape) labelOf;
  final ValueChanged<Shape> onPick;
  final String headerLabel;

  const _ShapePickerSheet({
    required this.selected,
    required this.labelOf,
    required this.onPick,
    required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = context.isDark;
    const all = Shape.values;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 4,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: colorScheme.outline.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    headerLabel,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
          ),
          // 2-column grid (all shapes)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: all.length,
              itemBuilder: (_, i) {
                final s = all[i];
                final isSel = s == selected;
                return GestureDetector(
                  onTap: () => onPick(s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSel
                          ? AppColors.primary
                              .withValues(alpha: isDark ? 0.28 : 0.12)
                          : colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSel
                            ? AppColors.primary.withValues(alpha: 0.65)
                            : colorScheme.outline.withValues(alpha: 0.16),
                        width: isSel ? 2 : 1,
                      ),
                      boxShadow: isSel
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          s.icon,
                          size: 20,
                          color: isSel
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.45),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              labelOf(s),
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: isSel
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSel
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurface
                                            .withValues(alpha: 0.65),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
