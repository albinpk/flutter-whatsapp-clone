import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';

final isMobile =
    !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia);

final lightThemeColors = CustomColors(
  chatsListTileTitle: const Color(0xFF111B21),
  chatsListTileSubtitle: const Color(0xFF667781),
  chatsListTileIcon: const Color(0xFF8696A0),
  chatsListTileBadge: const Color(0xFF25D366),
  primary: const Color(0xFF00A884),
  onPrimary: Colors.white,
  secondary: isMobile ? const Color(0xFF008069) : const Color(0xFFF0F2F5),
  onSecondary: isMobile ? Colors.white : const Color(0xFF111B21),
  surface: Colors.white,
  onSurface: const Color(0xFF111B21),
  onSurfaceMuted: const Color(0xFF667781),
);

const darkThemeColors = CustomColors(
  chatsListTileTitle: Color(0xFFE9EDEF),
  chatsListTileSubtitle: Color(0xFF8696A0),
  chatsListTileIcon: Color(0xFF888D90),
  chatsListTileBadge: Color(0xFF00A884),

  primary: Color(0xFF00A884),
  onPrimary: Colors.white,
  secondary: Color(0xFF202C33),
  onSecondary: Color(0xFFE9EDEF), // home Color(0xFF8696A0),
  surface: Color(0xFF111B21),
  onSurface: Color(0xFFE9EDEF),
  onSurfaceMuted: Color(0xFF8696A0),
);
