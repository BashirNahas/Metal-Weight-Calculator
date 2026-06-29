import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/repositories/calculation_repository.dart';

class HistoryProvider extends ChangeNotifier {
  final CalculationRepository _repository;
  List<Calculation> _history = [];

  HistoryProvider(this._repository) {
    _history = _repository.getAll();
  }

  List<Calculation> get history => List.unmodifiable(_history);
  List<Calculation> get favorites =>
      _history.where((c) => c.isFavorite).toList();

  bool get isEmpty => _history.isEmpty;

  Future<void> add(Calculation calc) async {
    _history.insert(0, calc);
    notifyListeners();
    await _repository.saveAll(_history);
  }

  Future<void> remove(String id) async {
    _history.removeWhere((c) => c.id == id);
    notifyListeners();
    await _repository.saveAll(_history);
  }

  Future<void> clearAll() async {
    _history.clear();
    notifyListeners();
    await _repository.saveAll(_history);
  }

  Future<void> toggleFavorite(String id) async {
    final idx = _history.indexWhere((c) => c.id == id);
    if (idx == -1) return;
    _history[idx] = _history[idx].copyWith(
      isFavorite: !_history[idx].isFavorite,
    );
    notifyListeners();
    await _repository.saveAll(_history);
  }
}
