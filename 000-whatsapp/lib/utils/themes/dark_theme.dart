import 'package:flutter/material.dart';

import 'colors.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: darkThemeColors.background,
  indicatorColor: darkThemeColors.primary,
  popupMenuTheme: PopupMenuThemeData(
    color: darkThemeColors.secondary,
  ),
  extensions: [darkThemeColors],
  colorScheme: _darkColorScheme,
);

final _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // AppBar
  surface: darkThemeColors.secondary!,
  onSurface: darkThemeColors.onSecondary!,
  // FAB
  secondary: darkThemeColors.primary!,
  onSecondary: darkThemeColors.onPrimary!,
  // Others (not using)
  primary: Colors.black,
  onPrimary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
);
