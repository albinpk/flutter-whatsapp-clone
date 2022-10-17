import 'package:flutter/material.dart';

import 'colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: lightThemeColors.background,
  indicatorColor: Colors.white,
  appBarTheme: const AppBarTheme(elevation: 1),
  popupMenuTheme: PopupMenuThemeData(
    color: isMobile ? Colors.white : lightThemeColors.secondary,
  ),
  listTileTheme: ListTileThemeData(
    textColor: lightThemeColors.onBackground,
    iconColor: lightThemeColors.iconMuted,
  ),
  dialogBackgroundColor: lightThemeColors.dialogBackground,
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
  error: const Color(0xFFEA0038),
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
);
