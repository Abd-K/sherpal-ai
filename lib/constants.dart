import 'package:flutter/material.dart';

class AppColors {
  static const Color ruby = Color(0xFFD91E1E);
  static const Color black = Color(0xFF121212);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF424242);
  static const Color offWhite = Color(0xFFFAFAFA);
  static const Color mediumGrey = Color(0xFF808080);

  static const LinearGradient rubyHorizontalGradient = LinearGradient(
    colors: [
      Color(0xFFAC0606),
      Color(0xFFF56060),
      Color(0xFFAC0606),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient rubyVerticalGradient = LinearGradient(
    colors: [
      Color(0xFFAC0606),
      Color(0xFFF56060),
      Color(0xFFAC0606),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
