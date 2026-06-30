enum MeasurementUnit {
  mm,
  cm,
  inch;

  /// Multiply a value in this unit by this factor to get centimeters.
  double get toCmFactor => switch (this) {
        MeasurementUnit.mm => 0.1,
        MeasurementUnit.cm => 1.0,
        MeasurementUnit.inch => 2.54,
      };

  String get symbol => switch (this) {
        MeasurementUnit.mm => 'mm',
        MeasurementUnit.cm => 'cm',
        MeasurementUnit.inch => 'in',
      };

  static MeasurementUnit fromIndex(int? index) {
    if (index == null) return MeasurementUnit.cm;
    return MeasurementUnit
        .values[index.clamp(0, MeasurementUnit.values.length - 1)];
  }
}
