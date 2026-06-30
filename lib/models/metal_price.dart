import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';

class MetalPrice {
  final String key;
  final String nameEn;
  final String nameAr;
  final String nameFr;
  final String nameDe;
  final double pricePerTonne;
  final String currency;
  final DateTime timestamp;

  const MetalPrice({
    required this.key,
    required this.nameEn,
    required this.nameAr,
    required this.nameFr,
    required this.nameDe,
    required this.pricePerTonne,
    required this.currency,
    required this.timestamp,
  });

  double get pricePerKg => pricePerTonne / 1000;

  // Troy ounces per metric tonne — matches the constant used to normalise
  // metals.dev's raw precious-metal USD/troy-oz quotes to USD/tonne.
  static const _troyOzPerTonne = 32_150.7466;

  double get pricePerOunce => pricePerTonne / _troyOzPerTonne;

  // Localized display name for a given language code, falling back to
  // English for any locale this model doesn't carry a name for.
  String nameFor(String languageCode) => switch (languageCode) {
        'ar' => nameAr,
        'fr' => nameFr,
        'de' => nameDe,
        _ => nameEn,
      };

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
        'nameFr': nameFr,
        'nameDe': nameDe,
        'pricePerTonne': pricePerTonne,
        'currency': currency,
        'timestamp': timestamp.toIso8601String(),
      };

  factory MetalPrice.fromJson(Map<String, dynamic> json) => MetalPrice(
        key: json['key'] as String,
        nameEn: json['nameEn'] as String,
        nameAr: json['nameAr'] as String,
        // Older cached entries (pre French/German support) won't have these.
        nameFr: json['nameFr'] as String? ?? json['nameEn'] as String,
        nameDe: json['nameDe'] as String? ?? json['nameEn'] as String,
        pricePerTonne: (json['pricePerTonne'] as num).toDouble(),
        currency: json['currency'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  static const Map<String, (String, String, String, String)> knownMetals = {
    'copper': ('Copper', 'نحاس', 'Cuivre', 'Kupfer'),
    'aluminum': ('Aluminum', 'ألومنيوم', 'Aluminium', 'Aluminium'),
    'aluminium': ('Aluminum', 'ألومنيوم', 'Aluminium', 'Aluminium'),
    'iron': ('Iron', 'حديد', 'Fer', 'Eisen'),
    'iron ore': ('Iron Ore', 'خام الحديد', 'Minerai de fer', 'Eisenerz'),
    'zinc': ('Zinc', 'زنك', 'Zinc', 'Zink'),
    'nickel': ('Nickel', 'نيكل', 'Nickel', 'Nickel'),
    'lead': ('Lead', 'رصاص', 'Plomb', 'Blei'),
    'tin': ('Tin', 'قصدير', 'Étain', 'Zinn'),
    'gold': ('Gold', 'ذهب', 'Or', 'Gold'),
    'silver': ('Silver', 'فضة', 'Argent', 'Silber'),
    'platinum': ('Platinum', 'بلاتين', 'Platine', 'Platin'),
    'palladium': ('Palladium', 'بلاديوم', 'Palladium', 'Palladium'),
    'steel': ('Steel', 'فولاذ', 'Acier', 'Stahl'),
    'XCU': ('Copper', 'نحاس', 'Cuivre', 'Kupfer'),
    'XAL': ('Aluminum', 'ألومنيوم', 'Aluminium', 'Aluminium'),
    'XZN': ('Zinc', 'زنك', 'Zinc', 'Zink'),
    'XNI': ('Nickel', 'نيكل', 'Nickel', 'Nickel'),
    'XAU': ('Gold', 'ذهب', 'Or', 'Gold'),
    'XAG': ('Silver', 'فضة', 'Argent', 'Silber'),
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
