import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:metal_weight_calculator/l10n/app_localizations.dart';
import 'package:metal_weight_calculator/providers/calculator_provider.dart';
import 'package:metal_weight_calculator/providers/history_provider.dart';
import 'package:metal_weight_calculator/providers/locale_provider.dart';
import 'package:metal_weight_calculator/providers/market_prices_provider.dart';
import 'package:metal_weight_calculator/providers/price_unit_provider.dart';
import 'package:metal_weight_calculator/providers/theme_provider.dart';
import 'package:metal_weight_calculator/providers/units_provider.dart';
import 'package:metal_weight_calculator/repositories/calculation_repository.dart';
import 'package:metal_weight_calculator/repositories/metal_price_repository.dart';
import 'package:metal_weight_calculator/screens/splash/splash_screen.dart';
import 'package:metal_weight_calculator/services/metal_price_service.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';
import 'package:metal_weight_calculator/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.instance.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MetalWeightApp());
}

class MetalWeightApp extends StatelessWidget {
  const MetalWeightApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService.instance;
    final calcRepo = CalculationRepository(storage);
    final priceRepo = MetalPriceRepository(
      const MetalPriceService(),
      storage,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider(calcRepo)),
        ChangeNotifierProvider(create: (_) => UnitsProvider()),
        ChangeNotifierProvider(create: (_) => PriceUnitProvider()),
        ChangeNotifierProvider(
          create: (_) => MarketPricesProvider(priceRepo),
        ),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, themeProvider, localeProvider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nahas MetalHub',
            themeMode: themeProvider.mode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
              Locale('fr'),
              Locale('de'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // Clamp accessibility font scaling so very large system fonts
            // don't break the app's fixed-size selector tiles.
            builder: (context, child) {
              final mq = MediaQuery.of(context);
              return MediaQuery(
                data: mq.copyWith(
                  textScaler: mq.textScaler.clamp(
                    minScaleFactor: 0.85,
                    maxScaleFactor: 1.25,
                  ),
                ),
                child: child!,
              );
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
