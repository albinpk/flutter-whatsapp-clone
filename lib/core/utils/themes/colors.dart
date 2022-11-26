import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';

final isMobile =
    !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia);

final lightThemeColors = CustomColors(
  primary: const Color(0xFF00A884),
  onPrimary: Colors.white,
  secondary: isMobile ? const Color(0xFF008069) : const Color(0xFFF0F2F5),
  onSecondary: isMobile ? Colors.white : const Color(0xFF111B21),
  onSecondaryMuted:
      isMobile ? const Color(0xFFE6F3F0) : const Color(0xFF667781),
  background: Colors.white,
  onBackground: const Color(0xFF111B21),
  onBackgroundMuted: const Color(0xFF667781),
  iconMuted: const Color(0xFF8696A0),
  chatRoomBackground: const Color(0xFFEFE7DE),
  sendMessageBubbleBackground: const Color(0xFFE7FFDB),
  receiveMessageBubbleBackground: Colors.white,
  readMessageCheckIcon: const Color(0xFF009DE2),
  dialogBackground: Colors.white,
);

final darkThemeColors = CustomColors(
  primary: const Color(0xFF00A884),
  onPrimary: Colors.white,
  secondary: const Color(0xFF202C33),
  onSecondary: const Color(0xFFE9EDEF), // home Color(0xFF8696A0),
  onSecondaryMuted:
      isMobile ? const Color(0xFFE9EAEB) : const Color(0xFF8696A0),
  background: const Color(0xFF111B21),
  onBackground: const Color(0xFFE9EDEF),
  onBackgroundMuted: const Color(0xFF8696A0),
  iconMuted: const Color(0xFF8696A0),
  chatRoomBackground: const Color(0xFF081419),
  sendMessageBubbleBackground: const Color(0xFF005C4B),
  receiveMessageBubbleBackground: const Color(0xFF202C33),
  readMessageCheckIcon: const Color(0xFF53BDEB),
  dialogBackground: const Color(0xFF2B3B45),
);
