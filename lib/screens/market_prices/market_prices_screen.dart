import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/core/utils/formatters.dart';
import 'package:metal_weight_calculator/providers/market_prices_provider.dart';
import 'package:metal_weight_calculator/widgets/market/price_card.dart';

class MarketPricesScreen extends StatefulWidget {
  const MarketPricesScreen({super.key});

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<MarketPricesProvider>();
      if (p.state == PriceState.idle) p.fetchPrices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isArabic = l10n.copper == 'نحاس';
    final locale = isArabic ? 'ar' : 'en';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.marketPrices),
        actions: [
          Consumer<MarketPricesProvider>(
            builder: (_, p, __) => p.state == PriceState.loading
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.secondary,
                      ),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    tooltip: l10n.refresh,
                    onPressed: () => p.fetchPrices(forceRefresh: true),
                  ),
          ),
        ],
      ),
      body: Consumer<MarketPricesProvider>(
        builder: (context, provider, _) {
          // RefreshIndicator needs a scrollable child for pull-to-refresh.
          // We always return a scrollable regardless of state.
          return RefreshIndicator(
            onRefresh: () => provider.fetchPrices(forceRefresh: true),
            color: AppColors.primary,
            child: _Body(
              provider: provider,
              locale: locale,
              isArabic: isArabic,
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final MarketPricesProvider provider;
  final String locale;
  final bool isArabic;

  const _Body({
    required this.provider,
    required this.locale,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = context.isDark;
    final colorScheme = Theme.of(context).colorScheme;
    final padding = EdgeInsets.symmetric(
      horizontal: context.isTablet ? 40 : 16,
      vertical: 12,
    );

    // Loading — no data yet
    if (provider.state == PriceState.loading && !provider.hasData) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(l10n.loading,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // Error — no data to show
    if (provider.state == PriceState.error && !provider.hasData) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.cloud_off_rounded,
                          color: AppColors.error, size: 36),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.failedToLoad,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.error,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.pullToRefresh,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () =>
                          provider.fetchPrices(forceRefresh: true),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Success (or stale data with a refresh happening)
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Last updated + stale error banner
              if (provider.lastUpdated != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${l10n.lastUpdated}: '
                            '${AppFormatters.dateTime(provider.lastUpdated!, locale: locale)}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : AppColors.textSecondaryLight,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (provider.state == PriceState.error && provider.hasData)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: AppColors.error, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.failedToLoad,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.error,
                                    ),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              provider.fetchPrices(forceRefresh: true),
                          child: Text(l10n.retry,
                              style:
                                  const TextStyle(color: AppColors.error)),
                        ),
                      ],
                    ),
                  ),
                ),

              // Price cards
              ...provider.prices.map((p) => PriceCard(price: p)),
              const SizedBox(height: 16),
            ]),
          ),
        ),
      ],
    );
  }
}
