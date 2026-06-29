import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:metal_weight_calculator/core/constants/app_constants.dart';
import 'package:metal_weight_calculator/models/metal_price.dart';

class MetalPriceService {
  const MetalPriceService();

  Future<List<MetalPrice>> fetchPrices() async {
    final directUri = Uri.parse(AppConstants.metalsApiBaseUrl).replace(
      queryParameters: {
        'api_key': AppConstants.metalsApiKey,
        'currency': 'USD',
        'unit': 'tonne',
      },
    );

    if (!kIsWeb) {
      final response = await http
          .get(directUri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 20));
      return _parse(response);
    }

    return _fetchWeb(directUri);
  }

  Future<List<MetalPrice>> _fetchWeb(Uri directUri) async {
    // ① Same-origin prices.json — populated by GitHub Actions every 4 h.
    //    No CORS headers needed because it's the same domain as the web app.
    try {
      final sameOriginUri = Uri.base.resolve('prices.json');
      final response = await http
          .get(sameOriginUri)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) return _parse(response);
    } catch (_) {
      // Not found or network error — fall through to proxies
    }

    // ② CORS proxies as fallback (both try to relay metals.dev with CORS headers)
    final encoded = Uri.encodeQueryComponent(directUri.toString());
    final proxies = [
      'https://api.allorigins.win/raw?url=$encoded',
      'https://corsproxy.io/?$encoded',
    ];

    Object? lastError;
    for (final url in proxies) {
      try {
        final response = await http
            .get(Uri.parse(url), headers: {'Accept': 'application/json'})
            .timeout(const Duration(seconds: 25));
        return _parse(response);
      } catch (e) {
        lastError = e;
      }
    }

    if (lastError is MetalPriceException) throw lastError;
    throw MetalPriceException(lastError?.toString() ?? 'All methods failed');
  }

  // metals.dev returns precious metals in USD/troy-oz regardless of unit=tonne.
  // Multiply these by troyOzPerTonne to normalise to USD/tonne.
  static const _troyOzPerTonne = 32_150.7466;
  static const _preciousMetalKeys = {'gold', 'silver', 'platinum', 'palladium'};

  List<MetalPrice> _parse(http.Response response) {
    if (response.statusCode != 200) {
      throw MetalPriceException(
        'Server returned ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }

    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw const MetalPriceException('Invalid response format');
    }

    final metals = body['metals'] as Map<String, dynamic>?;
    if (metals == null) {
      throw const MetalPriceException('No metals data in response');
    }

    // Handle both new API format (timestamps.metal) and bootstrap format (timestamp)
    final ts = body['timestamps'] is Map
        ? (body['timestamps'] as Map)['metal']
        : body['timestamp'];
    final timestamp = _parseTimestamp(ts);
    final results = <MetalPrice>[];

    for (final entry in metals.entries) {
      final key = entry.key.toLowerCase();
      // Skip LBMA/MCX/IBJA variants — use the clean keys only
      if (key.contains('_') || key.contains(' ore')) continue;
      final names =
          MetalPrice.knownMetals[key] ?? MetalPrice.knownMetals[entry.key];
      if (names == null) continue;

      final priceRaw = entry.value;
      double? price = priceRaw is num ? priceRaw.toDouble() : null;
      if (price == null || price <= 0) continue;

      // Convert precious metals from USD/troy-oz → USD/tonne
      if (_preciousMetalKeys.contains(key)) {
        price = price * _troyOzPerTonne;
      }

      results.add(MetalPrice(
        key: key,
        nameEn: names.$1,
        nameAr: names.$2,
        pricePerTonne: price,
        currency: 'USD',
        timestamp: timestamp,
      ));
    }

    results.sort((a, b) {
      final ai = MetalPrice.priorityMetals.indexOf(a.key);
      final bi = MetalPrice.priorityMetals.indexOf(b.key);
      return (ai == -1 ? 999 : ai).compareTo(bi == -1 ? 999 : bi);
    });

    return results;
  }

  DateTime _parseTimestamp(dynamic value) {
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }
}

class MetalPriceException implements Exception {
  final String message;
  final int? statusCode;
  const MetalPriceException(this.message, {this.statusCode});

  @override
  String toString() => 'MetalPriceException: $message';
}
