import 'package:flutter/material.dart';
import 'package:sherpal/constants.dart';

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // Container colors
    canvasColor: Colors.white,
    cardColor: AppColors.black,
    dialogBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    hintColor: AppColors.lightGrey,

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[300],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Icons
    iconTheme: IconThemeData(
      color: Colors.grey[300],
      size: 20,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // Container colors
    canvasColor: Colors.white,
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    hintColor: AppColors.darkGrey,

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade800,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Icons
    iconTheme: const IconThemeData(
      color: Colors.grey,
      size: 20,
    ),
  );
}
