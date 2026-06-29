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

    // On web, metals.dev doesn't send CORS headers, so requests are blocked by
    // the browser. Route through corsproxy.io which adds the required headers.
    final Uri uri;
    if (kIsWeb) {
      uri = Uri.parse(
        'https://corsproxy.io/?url=${Uri.encodeQueryComponent(directUri.toString())}',
      );
    } else {
      uri = directUri;
    }

    final response = await http
        .get(uri, headers: {'Accept': 'application/json'}).timeout(
      const Duration(seconds: 20),
    );

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
      final ai2 = ai == -1 ? 999 : ai;
      final bi2 = bi == -1 ? 999 : bi;
      return ai2.compareTo(bi2);
    });

    return results;
  }

  DateTime _parseTimestamp(dynamic value) {
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
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
