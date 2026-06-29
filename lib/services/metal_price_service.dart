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

    // On web, metals.dev doesn't include CORS headers so the browser blocks
    // direct requests. Try multiple free CORS proxies in order.
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
    throw MetalPriceException(lastError?.toString() ?? 'All proxies failed');
  }

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

    final timestamp = _parseTimestamp(body['timestamp']);
    final results = <MetalPrice>[];

    for (final entry in metals.entries) {
      final key = entry.key.toLowerCase();
      final names =
          MetalPrice.knownMetals[key] ?? MetalPrice.knownMetals[entry.key];
      if (names == null) continue;

      final priceRaw = entry.value;
      final price = priceRaw is num ? priceRaw.toDouble() : null;
      if (price == null || price <= 0) continue;

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
