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
    );
  }
}
