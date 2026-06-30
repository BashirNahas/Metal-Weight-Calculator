import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider() : _locale = StorageService.instance.loadLocale();

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    await StorageService.instance.saveLocale(locale);
  }
}
