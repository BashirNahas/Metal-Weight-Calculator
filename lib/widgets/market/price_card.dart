import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/core/utils/formatters.dart';
import 'package:metal_weight_calculator/l10n/app_localizations.dart';
import 'package:metal_weight_calculator/models/metal_price.dart';
import 'package:metal_weight_calculator/models/price_unit.dart';
import 'package:metal_weight_calculator/providers/price_unit_provider.dart';

class PriceCard extends StatelessWidget {
  final MetalPrice price;

  const PriceCard({super.key, required this.price});

  // Default (PriceUnit.tonne) reproduces the original tonne-primary /
  // kg-secondary layout exactly. Other selections swap the primary value
  // while keeping a sensible secondary reference value.
  (double, String) _primary(PriceUnit unit, AppLocalizations l10n) =>
      switch (unit) {
        PriceUnit.tonne => (price.pricePerTonne, l10n.perTonne),
        PriceUnit.kg => (price.pricePerKg, l10n.perKg),
        PriceUnit.ounce => (price.pricePerOunce, l10n.perOunce),
      };

  (double, String) _secondary(PriceUnit unit, AppLocalizations l10n) =>
      switch (unit) {
        PriceUnit.tonne => (price.pricePerKg, l10n.perKg),
        PriceUnit.kg => (price.pricePerTonne, l10n.perTonne),
        PriceUnit.ounce => (price.pricePerKg, l10n.perKg),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = context.isDark;
    final colorScheme = Theme.of(context).colorScheme;
    final isArabic = l10n.copper == 'نحاس';
    final selectedUnit = context.watch<PriceUnitProvider>().unit;

    final displayName = isArabic ? price.nameAr : price.nameEn;
    final locale = isArabic ? 'ar' : 'en';
    final (primaryValue, primaryLabel) = _primary(selectedUnit, l10n);
    final (secondaryValue, secondaryLabel) = _secondary(selectedUnit, l10n);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Metal color indicator
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: price.accentColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: price.accentColor.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  displayName.isNotEmpty ? displayName[0] : '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: price.accentColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Name & per-kg
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${AppFormatters.priceSimple(secondaryValue, locale: locale)} / $secondaryLabel',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                  ),
                ],
              ),
            ),
            // Primary price (driven by the user's selected price unit)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppFormatters.priceSimple(primaryValue, locale: locale),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  primaryLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontSize: 11,
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
