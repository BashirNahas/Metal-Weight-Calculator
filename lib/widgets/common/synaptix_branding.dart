import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';

class SynaptixBranding extends StatelessWidget {
  final bool compact;

  const SynaptixBranding({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = context.isDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!compact)
          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${l10n.poweredBy} ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.secondary, AppColors.primary],
              ).createShader(bounds),
              child: Text(
                'Synaptix',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
