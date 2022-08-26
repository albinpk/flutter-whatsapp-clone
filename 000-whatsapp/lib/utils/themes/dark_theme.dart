import 'package:flutter/material.dart';

import 'colors.dart';

final darkTheme = ThemeData(
  indicatorColor: const Color(0xFF00A884),
  scaffoldBackgroundColor: const Color(0xFF111B21),
  extensions: const [darkThemeColors],
  colorScheme: _darkColorScheme,
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // AppBar
  surface: Color(0xFF202C33),
  onSurface: Color(0xFF8696A0),
  // FAB
  secondary: Color(0xFF00A884),
  onSecondary: Colors.white,
  // Others (not using)
  primary: Colors.black,
  onPrimary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
);
