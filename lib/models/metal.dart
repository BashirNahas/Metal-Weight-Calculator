import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';

enum Metal {
  copper,
  aluminum,
  iron;

  double get density => switch (this) {
        Metal.copper => 8.96,
        Metal.aluminum => 2.70,
        Metal.iron => 7.85,
      };

  String get key => name;

  IconData get icon => switch (this) {
        Metal.copper => FontAwesomeIcons.ring,
        Metal.aluminum => FontAwesomeIcons.gears,
        Metal.iron => FontAwesomeIcons.hammer,
      };

  Color get accentColor => switch (this) {
        Metal.copper => AppColors.copperColor,
        Metal.aluminum => AppColors.aluminumColor,
        Metal.iron => AppColors.ironColor,
      };

  static Metal fromKey(String key) {
    return Metal.values.firstWhere(
      (m) => m.key == key,
      orElse: () => Metal.copper,
    );
  }
}

enum Shape {
  rectangle,
  circle;

  String get key => name;

  IconData get icon => switch (this) {
        Shape.rectangle => Icons.crop_landscape_rounded,
        Shape.circle => Icons.circle_outlined,
      };

  static Shape fromKey(String key) {
    return Shape.values.firstWhere(
      (s) => s.key == key,
      orElse: () => Shape.rectangle,
    );
  }
}
