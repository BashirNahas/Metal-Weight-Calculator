import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/core/utils/formatters.dart';
import 'package:metal_weight_calculator/models/metal_price.dart';

class PriceCard extends StatelessWidget {
  final MetalPrice price;

  const PriceCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = context.isDark;
    final colorScheme = Theme.of(context).colorScheme;
    final isArabic = l10n.copper == 'نحاس';

    final displayName = isArabic ? price.nameAr : price.nameEn;
    final locale = isArabic ? 'ar' : 'en';

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
                    '${AppFormatters.priceSimple(price.pricePerKg, locale: locale)} / ${l10n.perKg}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                  ),
                ],
              ),
            ),
            // Price per tonne
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppFormatters.priceSimple(price.pricePerTonne, locale: locale),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.perTonne,
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
