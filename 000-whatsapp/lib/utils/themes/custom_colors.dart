import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? chatsListTileTitle;
  final Color? chatsListTileSubtitle;
  final Color? chatsListTileIcon;
  final Color? chatsListTileBadge;

  const CustomColors({
    required this.chatsListTileTitle,
    required this.chatsListTileSubtitle,
    required this.chatsListTileIcon,
    required this.chatsListTileBadge,
  });

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? chatsListTileTitle,
    Color? chatsListTileSubtitle,
    Color? chatsListTileIcon,
    Color? chatsListTileBadge,
  }) {
    return CustomColors(
      chatsListTileTitle: chatsListTileTitle ?? this.chatsListTileTitle,
      chatsListTileSubtitle:
          chatsListTileSubtitle ?? this.chatsListTileSubtitle,
      chatsListTileIcon: chatsListTileIcon ?? this.chatsListTileIcon,
      chatsListTileBadge: chatsListTileBadge ?? this.chatsListTileBadge,
    );
  }

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
    );
  }

  static CustomColors of(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }
}
