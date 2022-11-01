import 'package:flutter/material.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import 'recent_chats_list_tile.dart';

/// Dialog widget that shows when pressed
/// on user dp in [RecentChatsListTile].
class DPDialog extends StatelessWidget {
  const DPDialog({
    super.key,
    required this.user,
  });

  final WhatsAppUser user;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final isLight = Theme.of(context).brightness == Brightness.light;

    final Image userDp;
    if (user.dpUrl != null) {
      userDp = Image.network(user.dpUrl!);
    } else {
      userDp = Image.asset(
        isLight
            ? 'assets/images/default-user-avatar-light.png'
            : 'assets/images/default-user-avatar-dark.png',
      );
    }

    return Dialog(
      backgroundColor: customColors.background,
      alignment: const Alignment(0, -0.7),
      insetPadding: const EdgeInsets.all(60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // User DP
              userDp,

              // User name
              SizedBox(
                width: double.infinity,
                child: ColoredBox(
                  color: Colors.black45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Option button
          IconTheme(
            data: IconThemeData(color: customColors.primary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
