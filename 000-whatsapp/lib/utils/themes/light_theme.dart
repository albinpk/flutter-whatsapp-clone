import 'package:flutter/material.dart';

import 'colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: lightThemeColors.background,
  indicatorColor: Colors.white,
  extensions: [lightThemeColors],
  colorScheme: _lightColorScheme,
);

final _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // AppBar
  primary: lightThemeColors.secondary!,
  onPrimary: lightThemeColors.onSecondary!,
  // FAB
  secondary: lightThemeColors.primary!,
  onSecondary: lightThemeColors.onPrimary!,
  // Others (not using)
  error: Colors.red,
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
);
