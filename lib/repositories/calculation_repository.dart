import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/services/storage_service.dart';

class CalculationRepository {
  final StorageService _storage;

  CalculationRepository(this._storage);

  List<Calculation> getAll() => _storage.loadHistory();

  Future<void> saveAll(List<Calculation> history) =>
      _storage.saveHistory(history);
}
