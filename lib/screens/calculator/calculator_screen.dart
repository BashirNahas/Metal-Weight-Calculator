import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/l10n/app_localizations.dart';
import 'package:metal_weight_calculator/models/metal.dart';
import 'package:metal_weight_calculator/providers/calculator_provider.dart';
import 'package:metal_weight_calculator/providers/history_provider.dart';
import 'package:metal_weight_calculator/providers/units_provider.dart';
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
    final unit = context.read<UnitsProvider>().unit;
    final l10n = context.l10n;

    final result = calc.calculate(unit: unit);
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
          SliverAppBar(
            expandedHeight: 96,
            pinned: true,
            // centerTitle ensures the FlexibleSpaceBar title is centred too
            centerTitle: true,
            backgroundColor:
                isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
            elevation: 0,
            scrolledUnderElevation: 0.8,
            shadowColor: Colors.black.withValues(alpha: 0.10),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                tooltip: l10n.reset,
                onPressed: () => _onReset(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // Symmetric horizontal padding so the title is truly centred
              titlePadding: const EdgeInsets.only(bottom: 12),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.appName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 1),
                  // Force LTR so Arabic RTL never reverses "Powered by Synaptix"
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Powered by ',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.secondary
                                        .withValues(alpha: 0.75),
                                    fontSize: 9.5,
                                    letterSpacing: 0.2,
                                  ),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [AppColors.secondary, AppColors.primary],
                          ).createShader(bounds),
                          child: Text(
                            'Synaptix',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.5,
                                  letterSpacing: 0.5,
                                ),
                          ),
                        ),
                      ],
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
                        : [Colors.white, const Color(0xFFF2F0F8)],
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
                  vertical: 10,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Metal selector card
                    SectionCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SectionHeader(
                            icon: Icons.category_outlined,
                            title: l10n.selectMetal,
                          ),
                          const SizedBox(height: 12),
                          MetalSelector(
                            selected: calc.selectedMetal,
                            onChanged: calc.selectMetal,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Shape selector card
                    SectionCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SectionHeader(
                            icon: Icons.square_outlined,
                            title: l10n.selectShape,
                          ),
                          const SizedBox(height: 10),
                          ShapeSelector(
                            selected: calc.selectedShape,
                            onChanged: calc.selectShape,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Measurements card
                    SectionCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SectionHeader(
                            icon: Icons.straighten_outlined,
                            title: l10n.enterMeasurements,
                          ),
                          const SizedBox(height: 12),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 280),
                            child: _MeasurementFields(
                              key: ValueKey(calc.selectedShape),
                              calc: calc,
                              l10n: l10n,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    GradientButton(
                      label: l10n.calculateWeight,
                      icon: Icons.calculate_rounded,
                      height: 52,
                      onPressed: () => _onCalculate(context),
                    ),
                    const SizedBox(height: 20),
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

/// Renders the measurement inputs for the currently selected [Shape].
/// Field controllers are reused across shapes with shifted meaning:
///   width    → side (squareBar) | across-flats (hexBar)
///   diameter → bar diameter (roundBar) | outer Ø (pipe)
///   thickness → wall thickness (pipe); unused for solid bars
class _MeasurementFields extends StatelessWidget {
  final CalculatorProvider calc;
  final AppLocalizations l10n;

  const _MeasurementFields({
    super.key,
    required this.calc,
    required this.l10n,
  });

  String _withUnit(String label, String symbol) => '$label ($symbol)';

  Widget _lengthField(String symbol) => MeasurementField(
        controller: calc.lengthController,
        label: _withUnit(l10n.length, symbol),
        icon: Icons.height_rounded,
        hasError: calc.fieldErrors['length'] ?? false,
        errorText: l10n.required,
        onChanged: (_) => calc.clearFieldError('length'),
      );

  Widget _widthField({
    required String label,
    required String symbol,
    required IconData icon,
  }) =>
      MeasurementField(
        controller: calc.widthController,
        label: _withUnit(label, symbol),
        icon: icon,
        hasError: calc.fieldErrors['width'] ?? false,
        errorText: l10n.required,
        onChanged: (_) => calc.clearFieldError('width'),
      );

  Widget _diameterField({required String label, required String symbol}) =>
      MeasurementField(
        controller: calc.diameterController,
        label: _withUnit(label, symbol),
        icon: Icons.radio_button_unchecked_rounded,
        hasError: calc.fieldErrors['diameter'] ?? false,
        errorText: l10n.required,
        onChanged: (_) => calc.clearFieldError('diameter'),
      );

  Widget _thicknessField({required String label, required String symbol}) =>
      MeasurementField(
        controller: calc.thicknessController,
        label: _withUnit(label, symbol),
        icon: Icons.layers_outlined,
        hasError: calc.fieldErrors['thickness'] ?? false,
        errorText: l10n.required,
        onChanged: (_) => calc.clearFieldError('thickness'),
      );

  Widget _row(Widget a, Widget b) => Row(
        children: [
          Expanded(child: a),
          const SizedBox(width: 12),
          Expanded(child: b),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<UnitsProvider>().unit;
    final symbol = unit.symbol;

    final fields = switch (calc.selectedShape) {
      Shape.rectangle => [
          _row(
            _lengthField(symbol),
            _widthField(
              label: l10n.width,
              symbol: symbol,
              icon: Icons.width_normal_rounded,
            ),
          ),
          const SizedBox(height: 14),
          _thicknessField(label: l10n.thickness, symbol: symbol),
        ],
      Shape.circle => [
          _diameterField(label: l10n.diameter, symbol: symbol),
          const SizedBox(height: 14),
          _thicknessField(label: l10n.thickness, symbol: symbol),
        ],
      Shape.squareBar => [
          _row(
            _lengthField(symbol),
            _widthField(
              label: l10n.side,
              symbol: symbol,
              icon: Icons.square_outlined,
            ),
          ),
        ],
      Shape.roundBar => [
          _row(_lengthField(symbol),
              _diameterField(label: l10n.diameter, symbol: symbol)),
        ],
      Shape.hexBar => [
          _row(
            _lengthField(symbol),
            _widthField(
              label: l10n.acrossFlats,
              symbol: symbol,
              icon: Icons.hexagon_outlined,
            ),
          ),
        ],
      Shape.pipe => [
          _row(_lengthField(symbol),
              _diameterField(label: l10n.outerDiameter, symbol: symbol)),
          const SizedBox(height: 14),
          _thicknessField(label: l10n.wallThickness, symbol: symbol),
        ],
      Shape.squareTube => [
          _row(
            _lengthField(symbol),
            _widthField(
              label: l10n.side,
              symbol: symbol,
              icon: Icons.crop_square_rounded,
            ),
          ),
          const SizedBox(height: 14),
          _thicknessField(label: l10n.wallThickness, symbol: symbol),
        ],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: fields,
    );
  }
}
