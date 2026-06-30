import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/core/utils/formatters.dart';
import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/providers/history_provider.dart';
import 'package:metal_weight_calculator/widgets/common/empty_state_widget.dart';
import 'package:metal_weight_calculator/widgets/dialogs/reset_confirm_dialog.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _favoritesOnly = false;

  Future<void> _clearAll(BuildContext context) async {
    final confirmed = await showClearHistoryDialog(context);
    if (confirmed && context.mounted) {
      await context.read<HistoryProvider>().clearAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.history),
        actions: [
          Consumer<HistoryProvider>(
            builder: (_, hp, __) => hp.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: l10n.clearAll,
                    onPressed: () => _clearAll(context),
                  ),
          ),
        ],
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, hp, _) {
          final items =
              _favoritesOnly ? hp.favorites : hp.history;

          return Column(
            children: [
              // Filter toggle
              if (!hp.isEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      _FilterChip(
                        label: l10n.allCalculations,
                        selected: !_favoritesOnly,
                        onTap: () =>
                            setState(() => _favoritesOnly = false),
                      ),
                      const SizedBox(width: 10),
                      _FilterChip(
                        label: l10n.favoritesOnly,
                        icon: Icons.star_rounded,
                        selected: _favoritesOnly,
                        onTap: () =>
                            setState(() => _favoritesOnly = true),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: items.isEmpty
                    ? EmptyStateWidget(
                        icon: _favoritesOnly
                            ? Icons.star_outline_rounded
                            : Icons.history_outlined,
                        message: _favoritesOnly
                            ? l10n.noFavorites
                            : l10n.noHistory,
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.isTablet ? 40 : 16,
                          vertical: 8,
                        ),
                        itemCount: items.length,
                        itemBuilder: (_, i) => _HistoryCard(
                          calculation: items[i],
                          key: ValueKey(items[i].id),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.12)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final Calculation calculation;

  const _HistoryCard({super.key, required this.calculation});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final c = calculation;
    final isDark = context.isDark;
    final metalName = l10n.metalLabel(c.metal);
    final shapeName = l10n.shapeLabel(c.shape);
    final locale = l10n.locale.languageCode;

    return Dismissible(
      key: ValueKey(c.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline_rounded,
            color: AppColors.error, size: 28),
      ),
      onDismissed: (_) => context.read<HistoryProvider>().remove(c.id),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Metal indicator
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: c.metal.accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  c.metal.icon,
                  color: c.metal.accentColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$metalName · $shapeName',
                      style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      AppFormatters.dateTime(c.timestamp, locale: locale),
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${AppFormatters.weight(c.weightKg)} ${l10n.kg}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () =>
                        context.read<HistoryProvider>().toggleFavorite(c.id),
                    child: Icon(
                      c.isFavorite
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: c.isFavorite
                          ? Colors.amber
                          : colorScheme.outline.withValues(alpha: 0.5),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
