import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/price_unit.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';

class PriceUnitProvider extends ChangeNotifier {
  PriceUnit _unit;

  PriceUnitProvider() : _unit = StorageService.instance.loadPriceUnit();

  PriceUnit get unit => _unit;

  Future<void> setUnit(PriceUnit unit) async {
    if (_unit == unit) return;
    _unit = unit;
    notifyListeners();
    await StorageService.instance.savePriceUnit(unit);
  }
}
