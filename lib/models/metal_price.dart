import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';

class MetalPrice {
  final String key;
  final String nameEn;
  final String nameAr;
  final double pricePerTonne;
  final String currency;
  final DateTime timestamp;

  const MetalPrice({
    required this.key,
    required this.nameEn,
    required this.nameAr,
    required this.pricePerTonne,
    required this.currency,
    required this.timestamp,
  });

  double get pricePerKg => pricePerTonne / 1000;

  // Troy ounces per metric tonne — matches the constant used to normalise
  // metals.dev's raw precious-metal USD/troy-oz quotes to USD/tonne.
  static const _troyOzPerTonne = 32_150.7466;

  double get pricePerOunce => pricePerTonne / _troyOzPerTonne;

  Color get accentColor => switch (key) {
        'copper' => AppColors.copperColor,
        'aluminum' || 'aluminium' => AppColors.aluminumColor,
        'iron' || 'iron ore' => AppColors.ironColor,
        'gold' => AppColors.goldColor,
        'silver' => AppColors.silverColor,
        'zinc' => AppColors.zincColor,
        'nickel' => AppColors.nickelColor,
        _ => AppColors.primary,
      };

  Map<String, dynamic> toJson() => {
        'key': key,
        'nameEn': nameEn,
        'nameAr': nameAr,
        'pricePerTonne': pricePerTonne,
        'currency': currency,
        'timestamp': timestamp.toIso8601String(),
      };

  factory MetalPrice.fromJson(Map<String, dynamic> json) => MetalPrice(
        key: json['key'] as String,
        nameEn: json['nameEn'] as String,
        nameAr: json['nameAr'] as String,
        pricePerTonne: (json['pricePerTonne'] as num).toDouble(),
        currency: json['currency'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  static const Map<String, (String, String)> knownMetals = {
    'copper': ('Copper', 'نحاس'),
    'aluminum': ('Aluminum', 'ألومنيوم'),
    'aluminium': ('Aluminum', 'ألومنيوم'),
    'iron': ('Iron', 'حديد'),
    'iron ore': ('Iron Ore', 'خام الحديد'),
    'zinc': ('Zinc', 'زنك'),
    'nickel': ('Nickel', 'نيكل'),
    'lead': ('Lead', 'رصاص'),
    'tin': ('Tin', 'قصدير'),
    'gold': ('Gold', 'ذهب'),
    'silver': ('Silver', 'فضة'),
    'platinum': ('Platinum', 'بلاتين'),
    'palladium': ('Palladium', 'بلاديوم'),
    'steel': ('Steel', 'فولاذ'),
    'XCU': ('Copper', 'نحاس'),
    'XAL': ('Aluminum', 'ألومنيوم'),
    'XZN': ('Zinc', 'زنك'),
    'XNI': ('Nickel', 'نيكل'),
    'XAU': ('Gold', 'ذهب'),
    'XAG': ('Silver', 'فضة'),
  };

  static const List<String> priorityMetals = [
    'copper',
    'aluminum',
    'aluminium',
    'iron',
    'iron ore',
    'zinc',
    'gold',
    'silver',
    'nickel',
    'lead',
    'tin',
    'steel',
  ];
}
