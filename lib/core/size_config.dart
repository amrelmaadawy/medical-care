import 'package:flutter/material.dart';

class SizeConfig {
  static late double width;
  static late double height;
  static late double text;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width / 100;
    height = size.height / 100;
    text = width;
  }
}

extension SizeExtension on num {
  double get w => this * SizeConfig.width;
  double get h => this * SizeConfig.height;
  double get sp => this * SizeConfig.text;
}
