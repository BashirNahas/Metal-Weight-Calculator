import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF4A4E69);
  static const Color secondary = Color(0xFF9A8C98);
  static const Color accent = Color(0xFF22223B);

  // Light theme surfaces
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFE9ECEF);
  static const Color textPrimaryLight = Color(0xFF22223B);
  static const Color textSecondaryLight = Color(0xFF6C757D);
  static const Color borderLight = Color(0xFFDEE2E6);

  // Dark theme surfaces
  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color cardDark = Color(0xFF1A1A2E);
  static const Color surfaceDark = Color(0xFF252538);
  static const Color textPrimaryDark = Color(0xFFE9ECEF);
  static const Color textSecondaryDark = Color(0xFFADB5BD);
  static const Color borderDark = Color(0xFF3A3A5C);

  // Semantic
  static const Color error = Color(0xFFE63946);
  static const Color errorLight = Color(0xFFFFEDEE);
  static const Color success = Color(0xFF2A9D8F);
  static const Color successLight = Color(0xFFE8F8F6);
  static const Color warning = Color(0xFFF4A261);
  static const Color info = Color(0xFF457B9D);

  // Metal accent colors
  static const Color copperColor = Color(0xFFB87333);
  static const Color aluminumColor = Color(0xFF848789);
  static const Color ironColor = Color(0xFF71797E);
  static const Color goldColor = Color(0xFFFFD700);
  static const Color silverColor = Color(0xFFC0C0C0);
  static const Color zincColor = Color(0xFF7C8C96);
  static const Color nickelColor = Color(0xFF857855);

  // Gradient
  static const List<Color> primaryGradient = [secondary, primary];
  static const List<Color> darkGradient = [
    Color(0xFF252538),
    Color(0xFF1A1A2E),
  ];
}
