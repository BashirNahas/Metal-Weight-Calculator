import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/core/utils/formatters.dart';
import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/providers/history_provider.dart';

class ResultDialog extends StatefulWidget {
  final Calculation calculation;

  const ResultDialog({super.key, required this.calculation});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.calculation.isFavorite;
  }

  String _buildShareText(BuildContext context) {
    final l10n = context.l10n;
    final c = widget.calculation;
    final metalName = l10n.metalLabel(c.metal);
    final shapeName = l10n.shapeLabel(c.shape);
    final weight = AppFormatters.weight(c.weightKg);

    return '${l10n.appName}\n'
        '$metalName - $shapeName\n'
        '${l10n.weight}: $weight ${l10n.kg}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = context.isDark;
    final c = widget.calculation;
    final metalName = l10n.metalLabel(c.metal);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/success_animation.json',
              width: 110,
              height: 110,
              repeat: false,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.result,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              metalName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: c.metal.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceDark
                    : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.scale_outlined,
                    color: colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppFormatters.weight(c.weightKg)} ${l10n.kg}',
                    style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Action buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.copy_outlined,
                  label: l10n.copyResult,
                  onTap: () async {
                    final text = _buildShareText(context);
                    await Clipboard.setData(ClipboardData(text: text));
                    if (context.mounted) context.showSnack(l10n.copied);
                  },
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: l10n.shareResult,
                  onTap: () async {
                    final text = _buildShareText(context);
                    await Share.share(text);
                  },
                ),
                _ActionButton(
                  icon: _isFavorite
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  label: _isFavorite
                      ? l10n.removeFavorite
                      : l10n.saveFavorite,
                  iconColor: _isFavorite ? Colors.amber : null,
                  onTap: () async {
                    await context
                        .read<HistoryProvider>()
                        .toggleFavorite(c.id);
                    if (!mounted) return;
                    setState(() => _isFavorite = !_isFavorite);
                    if (context.mounted) {
                      context.showSnack(
                        _isFavorite
                            ? l10n.savedToFavorites
                            : l10n.removedFromFavorites,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.close),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.calculateAgain),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor ?? colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
