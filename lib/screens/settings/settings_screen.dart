import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';
import 'package:metal_weight_calculator/core/constants/app_constants.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';
import 'package:metal_weight_calculator/models/measurement_unit.dart';
import 'package:metal_weight_calculator/models/price_unit.dart';
import 'package:metal_weight_calculator/providers/locale_provider.dart';
import 'package:metal_weight_calculator/providers/price_unit_provider.dart';
import 'package:metal_weight_calculator/providers/theme_provider.dart';
import 'package:metal_weight_calculator/providers/units_provider.dart';
import 'package:metal_weight_calculator/widgets/common/synaptix_branding.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = '${info.version}+${info.buildNumber}';
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) context.showSnack('Could not open link', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.isTablet ? 40 : 0,
          vertical: 8,
        ),
        children: [
          // Appearance
          _SectionTitle(title: l10n.appearance),
          _ThemeSelector(),
          const SizedBox(height: 4),
          _LanguageSelector(),
          const SizedBox(height: 8),

          // Calculator units
          _SectionTitle(title: l10n.calculator),
          _MeasurementUnitSelector(),
          const SizedBox(height: 8),

          // Price display unit
          _SectionTitle(title: l10n.prices),
          _PriceUnitSelector(),
          const SizedBox(height: 8),

          // About
          _SectionTitle(title: l10n.about),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            title: l10n.appName,
            subtitle: '${l10n.version} $_version',
          ),
          _SettingsTile(
            icon: Icons.person_outline_rounded,
            title: l10n.developer,
            subtitle: AppConstants.developerHandle,
          ),
          const SizedBox(height: 8),

          // Support
          _SectionTitle(title: l10n.support),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: l10n.privacyPolicy,
            onTap: () => _launchUrl(AppConstants.privacyPolicyUrl),
            trailing: const Icon(Icons.open_in_new_rounded, size: 18),
          ),
          _SettingsTile(
            icon: Icons.mail_outline_rounded,
            title: l10n.contactDeveloper,
            onTap: () => _launchUrl(AppConstants.contactEmail),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          _SettingsTile(
            icon: Icons.star_outline_rounded,
            title: l10n.rateApp,
            onTap: () => _launchUrl(AppConstants.playStoreUrl),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          _SettingsTile(
            icon: Icons.share_outlined,
            title: l10n.shareApp,
            onTap: () => Share.share(AppConstants.shareText),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const SizedBox(height: 24),

          // Powered by Synaptix
          const SynaptixBranding(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: colorScheme.primary, size: 22),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeProvider = context.watch<ThemeProvider>();

    final options = [
      (ThemeMode.light, l10n.light, Icons.light_mode_outlined),
      (ThemeMode.dark, l10n.dark, Icons.dark_mode_outlined),
      (ThemeMode.system, l10n.system, Icons.brightness_auto_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.palette_outlined,
                      size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.theme,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: options
                    .map((o) => Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3),
                            child: _ThemeChip(
                              label: o.$2,
                              icon: o.$3,
                              selected: themeProvider.mode == o.$1,
                              onTap: () =>
                                  themeProvider.setMode(o.$1),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeChip({
    required this.label,
    required this.icon,
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.12)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasurementUnitSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final unitsProvider = context.watch<UnitsProvider>();

    final options = [
      (MeasurementUnit.mm, l10n.millimeter, Icons.straighten_outlined),
      (MeasurementUnit.cm, l10n.centimeter, Icons.straighten_outlined),
      (MeasurementUnit.inch, l10n.inch, Icons.straighten_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.straighten_outlined,
                      size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.measurementUnit,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: options
                    .map((o) => Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3),
                            child: _ThemeChip(
                              label: o.$2,
                              icon: o.$3,
                              selected: unitsProvider.unit == o.$1,
                              onTap: () => unitsProvider.setUnit(o.$1),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceUnitSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final priceUnitProvider = context.watch<PriceUnitProvider>();

    final options = [
      (PriceUnit.tonne, l10n.tonneUnit, Icons.local_shipping_outlined),
      (PriceUnit.kg, l10n.kgUnit, Icons.scale_outlined),
      (PriceUnit.ounce, l10n.ounceUnit, Icons.monetization_on_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.payments_outlined,
                      size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.priceUnit,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: options
                    .map((o) => Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3),
                            child: _ThemeChip(
                              label: o.$2,
                              icon: o.$3,
                              selected: priceUnitProvider.unit == o.$1,
                              onTap: () => priceUnitProvider.setUnit(o.$1),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeProvider = context.watch<LocaleProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.language_outlined,
                      size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    l10n.language,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _LangTile(
                      code: 'ar',
                      label: l10n.arabic,
                      flag: '🇸🇦',
                      selected: localeProvider.isArabic,
                      onTap: () => localeProvider
                          .setLocale(const Locale('ar')),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _LangTile(
                      code: 'en',
                      label: l10n.english,
                      flag: '🇬🇧',
                      selected: !localeProvider.isArabic,
                      onTap: () => localeProvider
                          .setLocale(const Locale('en')),
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

class _LangTile extends StatelessWidget {
  final String code;
  final String label;
  final String flag;
  final bool selected;
  final VoidCallback onTap;

  const _LangTile({
    required this.code,
    required this.label,
    required this.flag,
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
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.12)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: selected
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              Icon(Icons.check_circle_rounded,
                  color: colorScheme.primary, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}
