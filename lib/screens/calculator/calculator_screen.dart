import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/models/metal.dart';
import 'package:metal_weight_calculator/providers/calculator_provider.dart';
import 'package:metal_weight_calculator/providers/history_provider.dart';
import 'package:metal_weight_calculator/widgets/calculator/measurement_field.dart';
import 'package:metal_weight_calculator/widgets/calculator/metal_selector.dart';
import 'package:metal_weight_calculator/widgets/calculator/shape_selector.dart';
import 'package:metal_weight_calculator/widgets/common/gradient_button.dart';
import 'package:metal_weight_calculator/widgets/common/section_card.dart';
import 'package:metal_weight_calculator/widgets/dialogs/reset_confirm_dialog.dart';
import 'package:metal_weight_calculator/widgets/dialogs/result_dialog.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  Future<void> _onCalculate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final calc = context.read<CalculatorProvider>();
    final l10n = context.l10n;

    final result = calc.calculate();
    if (result == null) {
      context.showSnack(l10n.fillAllFields, isError: true);
      return;
    }

    await context.read<HistoryProvider>().add(result);
    if (!context.mounted) return;

    final shouldReset = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ResultDialog(calculation: result),
    );

    if (shouldReset == true && context.mounted) {
      context.read<CalculatorProvider>().reset();
    }
  }

  Future<void> _onReset(BuildContext context) async {
    final confirmed = await showResetConfirmDialog(context);
    if (confirmed && context.mounted) {
      context.read<CalculatorProvider>().reset();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = context.isDark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Decorative SliverAppBar
          SliverAppBar(
            expandedHeight: 110,
            pinned: true,
            backgroundColor:
                isDark ? AppColors.cardDark : AppColors.cardLight,
            elevation: 0,
            scrolledUnderElevation: 1,
            shadowColor: Colors.black.withValues(alpha: 0.08),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                tooltip: l10n.reset,
                onPressed: () => _onReset(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(left: 20, bottom: 14, right: 60),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.appName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                  ),
                  Text(
                    'Powered by Synaptix',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary.withValues(alpha: 0.8),
                          fontSize: 10,
                          letterSpacing: 0.3,
                        ),
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [AppColors.cardDark, AppColors.surfaceDark]
                        : [Colors.white, const Color(0xFFF0EEF5)],
                  ),
                ),
              ),
            ),
          ),

          // Content
          Consumer<CalculatorProvider>(
            builder: (context, calc, _) {
              return SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isTablet ? 40 : 16,
                  vertical: 12,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Metal selector
                    SectionCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SectionHeader(
                            icon: Icons.category_outlined,
                            title: l10n.selectMetal,
                          ),
                          const SizedBox(height: 16),
                          MetalSelector(
                            selected: calc.selectedMetal,
                            onChanged: calc.selectMetal,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Shape selector
                    SectionCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SectionHeader(
                            icon: Icons.square_outlined,
                            title: l10n.selectShape,
                          ),
                          const SizedBox(height: 14),
                          ShapeSelector(
                            selected: calc.selectedShape,
                            onChanged: calc.selectShape,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Measurements
                    SectionCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SectionHeader(
                            icon: Icons.straighten_outlined,
                            title: l10n.enterMeasurements,
                          ),
                          const SizedBox(height: 16),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 280),
                            child: calc.selectedShape == Shape.rectangle
                                ? Row(
                                    key: const ValueKey('rect'),
                                    children: [
                                      Expanded(
                                        child: MeasurementField(
                                          controller: calc.lengthController,
                                          label: l10n.length,
                                          icon: Icons.height_rounded,
                                          hasError: calc.fieldErrors['length'] ??
                                              false,
                                          errorText: l10n.required,
                                          onChanged: (_) =>
                                              calc.clearFieldError('length'),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: MeasurementField(
                                          controller: calc.widthController,
                                          label: l10n.width,
                                          icon: Icons.width_normal_rounded,
                                          hasError: calc.fieldErrors['width'] ??
                                              false,
                                          errorText: l10n.required,
                                          onChanged: (_) =>
                                              calc.clearFieldError('width'),
                                        ),
                                      ),
                                    ],
                                  )
                                : MeasurementField(
                                    key: const ValueKey('circ'),
                                    controller: calc.diameterController,
                                    label: l10n.diameter,
                                    icon: Icons.radio_button_unchecked_rounded,
                                    hasError:
                                        calc.fieldErrors['diameter'] ?? false,
                                    errorText: l10n.required,
                                    onChanged: (_) =>
                                        calc.clearFieldError('diameter'),
                                  ),
                          ),
                          const SizedBox(height: 14),
                          MeasurementField(
                            controller: calc.thicknessController,
                            label: l10n.thickness,
                            icon: Icons.layers_outlined,
                            hasError:
                                calc.fieldErrors['thickness'] ?? false,
                            errorText: l10n.required,
                            onChanged: (_) =>
                                calc.clearFieldError('thickness'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    GradientButton(
                      label: l10n.calculateWeight,
                      icon: Icons.calculate_rounded,
                      onPressed: () => _onCalculate(context),
                    ),
                    const SizedBox(height: 32),
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
