import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  /// Primary color (tealGreen) for FloatingActionButton
  final Color? primary;
  final Color? onPrimary;

  /// Color for AppBar (mobile and desktop),
  /// InputArea (desktop)
  final Color? secondary;
  final Color? onSecondary;
  final Color? onSecondaryMuted;

  /// Scaffold background color
  final Color? background;
  final Color? onBackground;
  final Color? onBackgroundMuted;

  /// Icon color
  final Color? iconMuted;

  final Color? chatRoomBackground;

  // Message bubble colors
  final Color? sendMessageBubbleBackground;
  final Color? receiveMessageBubbleBackground;

  /// Message status icon color when status is [MessageStatus.read].
  final Color? readMessageCheckIcon;

  /// Background color for [Dialog] widget.
  final Color? dialogBackground;

  const CustomColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.onSecondaryMuted,
    required this.background,
    required this.onBackground,
    required this.onBackgroundMuted,
    required this.iconMuted,
    required this.chatRoomBackground,
    required this.sendMessageBubbleBackground,
    required this.receiveMessageBubbleBackground,
    required this.readMessageCheckIcon,
    required this.dialogBackground,
  });

  @override
  ThemeExtension<CustomColors> lerp(
    ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) return this;
    return CustomColors(
      primary: Color.lerp(primary, other.primary, t),
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t),
      onSecondaryMuted: Color.lerp(onSecondaryMuted, other.onSecondaryMuted, t),
      background: Color.lerp(background, other.background, t),
      onBackground: Color.lerp(onBackground, other.onBackground, t),
      onBackgroundMuted:
          Color.lerp(onBackgroundMuted, other.onBackgroundMuted, t),
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t),
      chatRoomBackground:
          Color.lerp(chatRoomBackground, other.chatRoomBackground, t),
      sendMessageBubbleBackground: Color.lerp(
          sendMessageBubbleBackground, other.sendMessageBubbleBackground, t),
      receiveMessageBubbleBackground: Color.lerp(receiveMessageBubbleBackground,
          other.receiveMessageBubbleBackground, t),
      readMessageCheckIcon:
          Color.lerp(readMessageCheckIcon, other.readMessageCheckIcon, t),
      dialogBackground: Color.lerp(dialogBackground, other.dialogBackground, t),
    );
  }

  static CustomColors of(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }

  @override
  CustomColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? onSecondaryMuted,
    Color? background,
    Color? onBackground,
    Color? onBackgroundMuted,
    Color? iconMuted,
    Color? chatRoomBackground,
    Color? sendMessageBubbleBackground,
    Color? receiveMessageBubbleBackground,
    Color? readMessageCheckIcon,
    Color? dialogBackground,
  }) {
    return CustomColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      onSecondaryMuted: onSecondaryMuted ?? this.onSecondaryMuted,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      onBackgroundMuted: onBackgroundMuted ?? this.onBackgroundMuted,
      iconMuted: iconMuted ?? this.iconMuted,
      chatRoomBackground: chatRoomBackground ?? this.chatRoomBackground,
      sendMessageBubbleBackground:
          sendMessageBubbleBackground ?? this.sendMessageBubbleBackground,
      receiveMessageBubbleBackground:
          receiveMessageBubbleBackground ?? this.receiveMessageBubbleBackground,
      readMessageCheckIcon: readMessageCheckIcon ?? this.readMessageCheckIcon,
      dialogBackground: dialogBackground ?? this.dialogBackground,
    );
  }
}
