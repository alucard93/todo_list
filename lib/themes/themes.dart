import 'package:flutter/material.dart';
import 'package:todo_list/themes/app_colors.dart';

ThemeData darkTheme() {
  return ThemeData.dark();
}

ThemeData lightTheme() {
  const primaryColor = Colors.indigo;
  return ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    cardTheme: CardThemeData(
      elevation: 3,
      color: primaryColor[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,

      foregroundColor: Colors.white,
    ),
    primaryColor: primaryColor,

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),

    extensions: [AppColors(primaryColor: primaryColor)],
  );
}
