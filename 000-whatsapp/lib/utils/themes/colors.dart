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
  onSecondaryMuted:
      isMobile ? const Color(0xFFE6F3F0) : const Color(0xFF667781),
  background: Colors.white,
  onBackground: const Color(0xFF111B21),
  onBackgroundMuted: const Color(0xFF667781),
);

final darkThemeColors = CustomColors(
  chatsListTileTitle: const Color(0xFFE9EDEF),
  chatsListTileSubtitle: const Color(0xFF8696A0),
  chatsListTileIcon: const Color(0xFF888D90),
  chatsListTileBadge: const Color(0xFF00A884),

  primary: const Color(0xFF00A884),
  onPrimary: Colors.white,
  secondary: const Color(0xFF202C33),
  onSecondary: const Color(0xFFE9EDEF), // home Color(0xFF8696A0),
  onSecondaryMuted:
      isMobile ? const Color(0xFFE9EAEB) : const Color(0xFF8696A0),
  background: const Color(0xFF111B21),
  onBackground: const Color(0xFFE9EDEF),
  onBackgroundMuted: const Color(0xFF8696A0),
);
