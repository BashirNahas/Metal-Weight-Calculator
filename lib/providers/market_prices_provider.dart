import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/metal_price.dart';
import 'package:metal_weight_calculator/repositories/metal_price_repository.dart';

enum PriceState { idle, loading, success, error }

class MarketPricesProvider extends ChangeNotifier {
  final MetalPriceRepository _repository;

  PriceState _state = PriceState.idle;
  List<MetalPrice> _prices = [];
  String? _errorMessage;
  DateTime? _lastUpdated;

  MarketPricesProvider(this._repository) {
    final cached = _repository.getCachedPrices();
    if (cached != null && cached.isNotEmpty) {
      _prices = cached;
      _lastUpdated = _repository.getLastUpdateTime();
      _state = PriceState.success;
    }
  }

  PriceState get state => _state;
  List<MetalPrice> get prices => _prices;
  String? get errorMessage => _errorMessage;
  DateTime? get lastUpdated => _lastUpdated;
  bool get hasData => _prices.isNotEmpty;

  Future<void> fetchPrices({bool forceRefresh = false}) async {
    if (_state == PriceState.loading) return;

    _state = PriceState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final prices =
          await _repository.getPrices(forceRefresh: forceRefresh);
      _prices = prices;
      _lastUpdated = _repository.getLastUpdateTime() ?? DateTime.now();
      _state = PriceState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = PriceState.error;
    }

    notifyListeners();
  }
}
