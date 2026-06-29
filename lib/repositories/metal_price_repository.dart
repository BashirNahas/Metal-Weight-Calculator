import 'package:metal_weight_calculator/models/metal_price.dart';
import 'package:metal_weight_calculator/services/metal_price_service.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';

class MetalPriceRepository {
  final MetalPriceService _service;
  final StorageService _storage;

  MetalPriceRepository(this._service, this._storage);

  Future<List<MetalPrice>> getPrices({bool forceRefresh = false}) async {
    if (!forceRefresh && _storage.isPriceCacheValid) {
      final cached = _storage.loadCachedPrices();
      if (cached != null && cached.isNotEmpty) return cached;
    }

    final prices = await _service.fetchPrices();
    await _storage.saveCachedPrices(prices);
    return prices;
  }

  List<MetalPrice>? getCachedPrices() => _storage.loadCachedPrices();

  DateTime? getLastUpdateTime() => _storage.loadLastPricesUpdate();
}
