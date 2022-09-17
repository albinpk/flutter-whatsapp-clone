import 'package:flutter/material.dart';
import 'package:whatsapp/utils/themes/custom_colors.dart';

class ItemCategoryTitle extends StatelessWidget {
  const ItemCategoryTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8).copyWith(left: 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
      ),
    );
  }
}
