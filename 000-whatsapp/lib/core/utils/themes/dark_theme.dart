import 'package:flutter/material.dart';

import 'colors.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: darkThemeColors.background,
  indicatorColor: darkThemeColors.primary,
  appBarTheme: const AppBarTheme(elevation: 1),
  popupMenuTheme: PopupMenuThemeData(
    color: darkThemeColors.secondary,
  ),
  listTileTheme: ListTileThemeData(
    textColor: darkThemeColors.onBackground,
    iconColor: lightThemeColors.iconMuted,
  ),
  dialogBackgroundColor: darkThemeColors.dialogBackground,
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
  error: const Color(0xFFF15C6D),
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
);
