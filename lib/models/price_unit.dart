enum PriceUnit {
  tonne,
  kg,
  ounce;

  static PriceUnit fromIndex(int? index) {
    if (index == null) return PriceUnit.tonne;
    return PriceUnit.values[index.clamp(0, PriceUnit.values.length - 1)];
  }
}
