import 'package:flutter/material.dart';

import '../utils/themes/custom_colors.dart';

/// Title for section of list items.
///
/// Used in: [UsersAndContactsView], [UserProfileScreen], [ChatsSettingsScreen].
class ListSectionTitle extends StatelessWidget {
  /// Title for section of list items.
  const ListSectionTitle(
    this.text, {
    super.key,
    this.textColor,
    this.padding,
  });

  /// Title text.
  final String text;

  /// Title text color.
  final Color? textColor;

  /// Padding around title.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 15, left: 15, bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: textColor ?? CustomColors.of(context).onBackgroundMuted,
            ),
      ),
    );
  }
}
