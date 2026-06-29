import 'dart:math' as math;
import 'package:metal_weight_calculator/models/metal.dart';

class Calculation {
  final String id;
  final Metal metal;
  final Shape shape;
  final double? length;
  final double? width;
  final double? diameter;
  final double thickness; // mm for plate/disc/pipe wall; 0 for bar shapes
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
    this.thickness = 0,
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
    double thickness = 0,
  }) {
    // All linear dimensions are in cm. Thickness is in mm → divide by 10.
    final double volume = switch (shape) {
      // Rectangular plate/sheet: L × W × T(mm→cm)
      Shape.rectangle =>
        (length ?? 0) * (width ?? 0) * (thickness / 10),

      // Circular disc: π × r² × T(mm→cm)
      Shape.circle =>
        math.pi * math.pow((diameter ?? 0) / 2, 2) * (thickness / 10),

      // Square bar: side² × length (all cm)
      Shape.squareBar =>
        math.pow(width ?? 0, 2).toDouble() * (length ?? 0),

      // Round bar: π × r² × length (all cm)
      Shape.roundBar =>
        math.pi * math.pow((diameter ?? 0) / 2, 2) * (length ?? 0),

      // Hexagonal bar: (√3/2) × AF² × length  (AF = across-flats in cm)
      // Area of regular hexagon given across-flats = (√3/2) × AF²
      Shape.hexBar =>
        (math.sqrt(3) / 2) * math.pow(width ?? 0, 2) * (length ?? 0),

      // Hollow pipe: π/4 × (OD² − ID²) × length
      // OD = diameter (cm), wall = thickness (mm→cm), ID = OD − 2×wall
      Shape.pipe => () {
          final od = diameter ?? 0;
          final wallCm = thickness / 10;
          final id = od - 2 * wallCm;
          if (id <= 0) return 0.0;
          return math.pi / 4.0 * ((od * od) - (id * id)) * (length ?? 0);
        }(),
    };

    // volume (cm³) × density (g/cm³) / 1000 = kg
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
        thickness: (json['thickness'] as num?)?.toDouble() ?? 0,
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
