import 'package:flutter/material.dart';
import 'package:todo_list/themes/app_colors.dart';

ThemeData darkTheme() {
  const primaryColor = Colors.orange;
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: primaryColor,
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: primaryColor.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(primaryColor),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),

    extensions: [AppColors(primaryColor: primaryColor)],
  );
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

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
    ),

    extensions: [AppColors(primaryColor: primaryColor)],
  );
}
