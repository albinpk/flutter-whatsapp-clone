import 'package:flutter/material.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';

class ButtonListTile extends StatelessWidget {
  const ButtonListTile({
    Key? key,
    required this.title,
    required this.iconData,
    this.trailing,
  })  : isLite = false,
        super(key: key);

  const ButtonListTile.lite({
    Key? key,
    required this.title,
    required this.iconData,
  })  : isLite = true,
        trailing = null,
        super(key: key);

  final String title;
  final IconData iconData;
  final Widget? trailing;
  final bool isLite;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return ListTile(
      minVerticalPadding: 25,
      leading: CircleAvatar(
        backgroundColor: isLite
            ? customColors.iconMuted!.withOpacity(0.2)
            : customColors.primary,
        foregroundColor:
            isLite ? customColors.iconMuted : customColors.onPrimary,
        child: Icon(iconData),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: trailing,
    );
  }
}
