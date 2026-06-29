import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'Metal Weight Calculator';
  static const String appVersion = '1.0.1';
  static const String buildNumber = '2';
  static const String developerHandle = '@Bashir_Nahas';
  static const String companyName = 'Synaptix';
  static const String contactEmail = 'mailto:bashir.nahas97@gmail.com';
  static const String privacyPolicyUrl = 'https://example.com/privacy-policy';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.synaptix.metalweightcalculator';
  static const String shareText =
      'Check out Metal Weight Calculator - a professional tool for calculating metal weights! Download now.';

  // API — pass via --dart-define=METALS_API_KEY=your_key at build time
  static const String metalsApiBaseUrl = 'https://metals.dev/api/latest';
  static const String metalsApiKey = String.fromEnvironment(
    'METALS_API_KEY',
    defaultValue: 'GSXSD3M4DWA63FI2G0TA771I2G0TA',
  );

  // Cache
  static const Duration pricesCacheDuration = Duration(minutes: 15);

  // SharedPreferences keys
  static const String kThemeMode = 'theme_mode';
  static const String kLocale = 'locale';
  static const String kCalculationHistory = 'calculation_history';
  static const String kLastPricesUpdate = 'last_prices_update';
  static const String kCachedPrices = 'cached_prices';

  // Densities g/cm³
  static const double copperDensity = 8.96;
  static const double aluminumDensity = 2.70;
  static const double ironDensity = 7.85;

  static const int maxHistoryItems = 100;

  // Breakpoints
  static const double tabletBreakpoint = 600.0;

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 600);

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;
}
