import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode;

  ThemeProvider() : _mode = StorageService.instance.loadThemeMode();

  ThemeMode get mode => _mode;

  Future<void> setMode(ThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
    await StorageService.instance.saveThemeMode(mode);
  }
}
