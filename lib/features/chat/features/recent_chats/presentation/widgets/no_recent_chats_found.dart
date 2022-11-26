import 'package:flutter/material.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';

class NoRecentChatsFound extends StatelessWidget {
  const NoRecentChatsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Start new chat',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
      ),
    );
  }
}
