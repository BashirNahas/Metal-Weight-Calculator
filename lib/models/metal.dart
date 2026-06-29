import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';

enum Metal {
  copper,
  aluminum,
  iron,
  steel,
  stainlessSteel,
  zinc,
  nickel,
  lead,
  brass,
  titanium,
  gold,
  silver;

  double get density => switch (this) {
        Metal.copper => 8.96,
        Metal.aluminum => 2.70,
        Metal.iron => 7.85,
        Metal.steel => 7.85,
        Metal.stainlessSteel => 8.00,
        Metal.zinc => 7.13,
        Metal.nickel => 8.91,
        Metal.lead => 11.34,
        Metal.brass => 8.50,
        Metal.titanium => 4.51,
        Metal.gold => 19.30,
        Metal.silver => 10.49,
      };

  String get key => name;

  IconData get icon => switch (this) {
        Metal.copper => FontAwesomeIcons.ring,
        Metal.aluminum => FontAwesomeIcons.gears,
        Metal.iron => FontAwesomeIcons.hammer,
        Metal.steel => Icons.view_module_rounded,
        Metal.stainlessSteel => Icons.water_drop_outlined,
        Metal.zinc => Icons.hexagon_outlined,
        Metal.nickel => Icons.circle_outlined,
        Metal.lead => FontAwesomeIcons.weightHanging,
        Metal.brass => Icons.plumbing_rounded,  // brass is widely used in plumbing fittings
        Metal.titanium => Icons.science_outlined,
        Metal.gold => FontAwesomeIcons.coins,
        Metal.silver => Icons.paid_outlined,
      };

  Color get accentColor => switch (this) {
        Metal.copper => AppColors.copperColor,
        Metal.aluminum => AppColors.aluminumColor,
        Metal.iron => AppColors.ironColor,
        Metal.steel => AppColors.steelColor,
        Metal.stainlessSteel => AppColors.stainlessSteelColor,
        Metal.zinc => AppColors.zincColor,
        Metal.nickel => AppColors.nickelColor,
        Metal.lead => AppColors.leadColor,
        Metal.brass => AppColors.brassColor,
        Metal.titanium => AppColors.titaniumColor,
        Metal.gold => AppColors.goldColor,
        Metal.silver => AppColors.silverColor,
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
  circle,
  squareBar,
  roundBar,
  hexBar,
  pipe;

  String get key => name;

  IconData get icon => switch (this) {
        Shape.rectangle => Icons.crop_landscape_rounded,
        Shape.circle => Icons.circle_outlined,
        Shape.squareBar => Icons.stop_rounded,
        Shape.roundBar => Icons.lens,
        Shape.hexBar => Icons.hexagon,
        Shape.pipe => Icons.donut_large_rounded,
      };

  bool get isPrimary =>
      this == Shape.rectangle || this == Shape.circle;

  static Shape fromKey(String key) {
    return Shape.values.firstWhere(
      (s) => s.key == key,
      orElse: () => Shape.rectangle,
    );
  }
}
