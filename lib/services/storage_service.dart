import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metal_weight_calculator/core/constants/app_constants.dart';
import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/models/measurement_unit.dart';
import 'package:metal_weight_calculator/models/metal_price.dart';
import 'package:metal_weight_calculator/models/price_unit.dart';

class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get _p {
    assert(_prefs != null, 'StorageService.init() must be called before use');
    return _prefs!;
  }

  // --- Theme ---

  Future<void> saveThemeMode(ThemeMode mode) =>
      _p.setInt(AppConstants.kThemeMode, mode.index);

  ThemeMode loadThemeMode() {
    final idx = _p.getInt(AppConstants.kThemeMode);
    if (idx == null) return ThemeMode.system;
    return ThemeMode.values[idx.clamp(0, ThemeMode.values.length - 1)];
  }

  // --- Locale ---

  static const _supportedLocaleCodes = {'ar', 'en', 'fr', 'de'};

  Future<void> saveLocale(Locale locale) =>
      _p.setString(AppConstants.kLocale, locale.languageCode);

  // No saved preference yet: default to the device/browser locale (web picks
  // up navigator.language, native picks up the OS locale) when it's one of
  // our supported languages, otherwise fall back to English.
  Locale loadLocale() {
    final code = _p.getString(AppConstants.kLocale);
    if (code != null) return Locale(code);

    final deviceCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return Locale(
      _supportedLocaleCodes.contains(deviceCode) ? deviceCode : 'en',
    );
  }

  // --- History ---

  Future<void> saveHistory(List<Calculation> history) async {
    final list = history.take(AppConstants.maxHistoryItems).map((c) => jsonEncode(c.toJson())).toList();
    await _p.setStringList(AppConstants.kCalculationHistory, list);
  }

  List<Calculation> loadHistory() {
    final list = _p.getStringList(AppConstants.kCalculationHistory) ?? [];
    return list
        .map((s) {
          try {
            return Calculation.fromJson(jsonDecode(s) as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        })
        .whereType<Calculation>()
        .toList();
  }

  // --- Metal prices cache ---

  Future<void> saveCachedPrices(List<MetalPrice> prices) async {
    final list = prices.map((p) => jsonEncode(p.toJson())).toList();
    await _p.setStringList(AppConstants.kCachedPrices, list);
    await _p.setString(
      AppConstants.kLastPricesUpdate,
      DateTime.now().toIso8601String(),
    );
  }

  List<MetalPrice>? loadCachedPrices() {
    final list = _p.getStringList(AppConstants.kCachedPrices);
    if (list == null || list.isEmpty) return null;
    try {
      return list
          .map((s) => MetalPrice.fromJson(jsonDecode(s) as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  DateTime? loadLastPricesUpdate() {
    final s = _p.getString(AppConstants.kLastPricesUpdate);
    if (s == null) return null;
    return DateTime.tryParse(s);
  }

  bool get isPriceCacheValid {
    final last = loadLastPricesUpdate();
    if (last == null) return false;
    return DateTime.now().difference(last) < AppConstants.pricesCacheDuration;
  }

  // --- Measurement unit ---

  Future<void> saveMeasurementUnit(MeasurementUnit unit) =>
      _p.setInt(AppConstants.kMeasurementUnit, unit.index);

  MeasurementUnit loadMeasurementUnit() =>
      MeasurementUnit.fromIndex(_p.getInt(AppConstants.kMeasurementUnit));

  // --- Price unit ---

  Future<void> savePriceUnit(PriceUnit unit) =>
      _p.setInt(AppConstants.kPriceUnit, unit.index);

  PriceUnit loadPriceUnit() =>
      PriceUnit.fromIndex(_p.getInt(AppConstants.kPriceUnit));
}
