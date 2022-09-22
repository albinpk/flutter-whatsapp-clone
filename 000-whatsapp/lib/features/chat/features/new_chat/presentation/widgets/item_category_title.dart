import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/platform_type.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';

class ItemCategoryTitle extends StatelessWidget {
  const ItemCategoryTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    final customColors = CustomColors.of(context);

    return Padding(
      padding: isMobile
          ? const EdgeInsets.all(8).copyWith(left: 15)
          : const EdgeInsets.all(25).copyWith(left: 30),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: isMobile
                  ? customColors.onBackgroundMuted
                  : customColors.primary,
            ),
      ),
    );
  }
}
