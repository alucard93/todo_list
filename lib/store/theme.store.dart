import 'package:flutter/material.dart';

class ThemeStore {
  final theMode = ValueNotifier(ThemeMode.system);

  void setThemeMode(ThemeMode mode) => theMode.value = mode;
}
