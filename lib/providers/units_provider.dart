import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/measurement_unit.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';

class UnitsProvider extends ChangeNotifier {
  MeasurementUnit _unit;

  UnitsProvider() : _unit = StorageService.instance.loadMeasurementUnit();

  MeasurementUnit get unit => _unit;

  Future<void> setUnit(MeasurementUnit unit) async {
    if (_unit == unit) return;
    _unit = unit;
    notifyListeners();
    await StorageService.instance.saveMeasurementUnit(unit);
  }
}
