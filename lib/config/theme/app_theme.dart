import 'package:flutter/material.dart';
import 'package:moviki/config/theme/app_color.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColor.colorScheme,
      primaryColor: AppColor.primary,
      dividerColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.background,
        foregroundColor: AppColor.labelOne,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.background,
        unselectedItemColor: AppColor.labelThree,
        selectedItemColor: AppColor.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      iconTheme: const IconThemeData(
        color: AppColor.primary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: AppColor.background,
          foregroundColor: AppColor.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 12,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.labelOne,
          shadowColor: AppColor.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColor.transparent,
          foregroundColor: AppColor.labelOne,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColor.searchBar,
        hintStyle: TextStyle(color: AppColor.labelFour),
        suffixIconColor: AppColor.primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(
            color: AppColor.transparent,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(
            color: AppColor.transparent,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColor.labelOne,
          fontSize: 36,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: TextStyle(
          color: AppColor.labelThree,
          fontSize: 32,
          fontWeight: FontWeight.normal,
        ),
        displaySmall: TextStyle(
          color: AppColor.labelFour,
          fontSize: 28,
          fontWeight: FontWeight.normal,
        ),
        headlineLarge: TextStyle(
          color: AppColor.labelOne,
          fontSize: 26,
          fontWeight: FontWeight.normal,
        ),
        headlineMedium: TextStyle(
          color: AppColor.labelThree,
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
        headlineSmall: TextStyle(
          color: AppColor.labelFour,
          fontSize: 22,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: TextStyle(
          color: AppColor.labelOne,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        titleMedium: TextStyle(
          color: AppColor.labelThree,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        titleSmall: TextStyle(
          color: AppColor.labelFour,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: TextStyle(
          color: AppColor.labelOne,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: AppColor.labelThree,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: AppColor.labelFour,
          fontSize: 8,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: AppColor.labelOne,
          fontSize: 8,
          fontWeight: FontWeight.normal,
        ),
        labelMedium: TextStyle(
          color: AppColor.labelThree,
          fontSize: 8,
          fontWeight: FontWeight.normal,
        ),
        labelSmall: TextStyle(
          color: AppColor.labelFour,
          fontSize: 6,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
