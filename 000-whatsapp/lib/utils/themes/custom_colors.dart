import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  @Deprecated('deprecated')
  final Color? chatsListTileTitle;
  @Deprecated('deprecated')
  final Color? chatsListTileSubtitle;
  @Deprecated('deprecated')
  final Color? chatsListTileIcon;
  @Deprecated('deprecated')
  final Color? chatsListTileBadge;

  /// Primary color (tealGreen) for FloatingActionButton
  final Color? primary;
  final Color? onPrimary;

  /// Color for AppBar (mobile and desktop),
  /// InputArea (desktop)
  final Color? secondary;
  final Color? onSecondary;

  /// Scaffold background color
  final Color? surface;
  final Color? onSurface;
  final Color? onSurfaceMuted;

  const CustomColors({
    required this.chatsListTileTitle,
    required this.chatsListTileSubtitle,
    required this.chatsListTileIcon,
    required this.chatsListTileBadge,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceMuted,
  });

  @override
  ThemeExtension<CustomColors> lerp(
    ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) return this;
    return CustomColors(
      chatsListTileTitle:
          Color.lerp(chatsListTileTitle, other.chatsListTileTitle, t),
      chatsListTileSubtitle:
          Color.lerp(chatsListTileSubtitle, other.chatsListTileSubtitle, t),
      chatsListTileIcon:
          Color.lerp(chatsListTileIcon, other.chatsListTileIcon, t),
      chatsListTileBadge:
          Color.lerp(chatsListTileBadge, other.chatsListTileBadge, t),
      primary: Color.lerp(primary, other.primary, t),
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t),
      surface: Color.lerp(surface, other.surface, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
      onSurfaceMuted: Color.lerp(onSurfaceMuted, other.onSurfaceMuted, t),
    );
  }

  static CustomColors of(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }

  @override
  CustomColors copyWith({
    Color? chatsListTileTitle,
    Color? chatsListTileSubtitle,
    Color? chatsListTileIcon,
    Color? chatsListTileBadge,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceMuted,
  }) {
    return CustomColors(
      chatsListTileTitle: chatsListTileTitle ?? this.chatsListTileTitle,
      chatsListTileSubtitle:
          chatsListTileSubtitle ?? this.chatsListTileSubtitle,
      chatsListTileIcon: chatsListTileIcon ?? this.chatsListTileIcon,
      chatsListTileBadge: chatsListTileBadge ?? this.chatsListTileBadge,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
    );
  }
}
