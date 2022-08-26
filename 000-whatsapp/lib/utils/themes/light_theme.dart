import 'package:flutter/material.dart';

import 'colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  indicatorColor: Colors.white,
  extensions: const [lightThemeColors],
  colorScheme: _lightColorScheme,
);

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // AppBar
  primary: Color(0xFF008069),
  onPrimary: Colors.white,
  // FAB
  secondary: Color(0xFF00A884),
  onSecondary: Colors.white,
  // Others (not using)
  error: Colors.red,
  onError: Colors.white,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
);
