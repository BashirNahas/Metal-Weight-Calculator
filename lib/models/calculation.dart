import 'dart:math' as math;
import 'package:metal_weight_calculator/models/metal.dart';

class Calculation {
  final String id;
  final Metal metal;
  final Shape shape;
  final double? length;
  final double? width;
  final double? diameter;
  final double thickness;
  final double weightKg;
  bool isFavorite;
  final DateTime timestamp;

  Calculation({
    required this.id,
    required this.metal,
    required this.shape,
    this.length,
    this.width,
    this.diameter,
    required this.thickness,
    required this.weightKg,
    this.isFavorite = false,
    required this.timestamp,
  });

  factory Calculation.compute({
    required Metal metal,
    required Shape shape,
    double? length,
    double? width,
    double? diameter,
    required double thickness,
  }) {
    double volume;
    if (shape == Shape.rectangle) {
      volume = (length ?? 0) * (width ?? 0) * (thickness / 10);
    } else {
      final r = (diameter ?? 0) / 2;
      volume = math.pi * r * r * (thickness / 10);
    }
    final weight = volume * metal.density / 1000;

    return Calculation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      metal: metal,
      shape: shape,
      length: length,
      width: width,
      diameter: diameter,
      thickness: thickness,
      weightKg: weight,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'metal': metal.key,
        'shape': shape.key,
        'length': length,
        'width': width,
        'diameter': diameter,
        'thickness': thickness,
        'weightKg': weightKg,
        'isFavorite': isFavorite,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
        id: json['id'] as String,
        metal: Metal.fromKey(json['metal'] as String),
        shape: Shape.fromKey(json['shape'] as String),
        length: (json['length'] as num?)?.toDouble(),
        width: (json['width'] as num?)?.toDouble(),
        diameter: (json['diameter'] as num?)?.toDouble(),
        thickness: (json['thickness'] as num).toDouble(),
        weightKg: (json['weightKg'] as num).toDouble(),
        isFavorite: json['isFavorite'] as bool? ?? false,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  Calculation copyWith({bool? isFavorite}) => Calculation(
        id: id,
        metal: metal,
        shape: shape,
        length: length,
        width: width,
        diameter: diameter,
        thickness: thickness,
        weightKg: weightKg,
        isFavorite: isFavorite ?? this.isFavorite,
        timestamp: timestamp,
      );
}
