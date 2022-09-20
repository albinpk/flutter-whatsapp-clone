import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'list_item.dart';

class ButtonItem implements ListItem {
  final String title;
  final IconData iconData;
  final Widget? trailing;
  final bool isLite;

  const ButtonItem({
    required this.title,
    required this.iconData,
    this.trailing,
    this.isLite = false,
  });

  @override
  Widget buildItem(context) {
    return isLite
        ? ButtonListTile.lite(title: title, iconData: iconData)
        : ButtonListTile(
            title: title,
            iconData: iconData,
            trailing: trailing,
          );
  }
}
