import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../home_screen/home_screen.dart';
import '../../../../chat.dart';

class RecentChatsListTile extends StatelessWidget {
  const RecentChatsListTile({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final RecentChat chat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final isDesktop = theme.platform.isDesktop;

    bool isSelected = false;
    if (isDesktop) {
      // To highlight selected chat on desktop
      isSelected = context.select(
        (ChatRoomBloc bloc) {
          return bloc.state is ChatRoomOpenState &&
              (bloc.state as ChatRoomOpenState).user == chat.user;
        },
      );
    }

    final lastMessageTextStyle = theme.textTheme.bodyMedium!.copyWith(
      color: customColors.onBackgroundMuted,
    );

    return ListTile(
      selected: isSelected,
      selectedTileColor: customColors.secondary,
      leading: GestureDetector(
        onTap: !isDesktop ? () => _showDpDialog(context) : null,
        child: UserDP(radius: 25, url: chat.user.dpUrl),
      ),
      title: Row(
        children: [
          // User name
          Expanded(
            child: Text(
              chat.user.name,
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: customColors.onBackground,
              ),
            ),
          ),

          // Last message time
          Text(
            _formatDate(chat.lastMessage.time),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            // Message status
            if (chat.lastMessage.author == context.watch<User>())
              MessageStatusIcon(
                status: chat.lastMessage.status,
                color: lastMessageTextStyle.color!,
              ),

            // Last message
            Expanded(
              child: Text(
                chat.lastMessage.content.text.split('\n').join(' '),
                style: lastMessageTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Icons (muted, pinned, unread message)
            IconTheme(
              data: IconTheme.of(context).copyWith(
                size: 20,
                color: customColors.iconMuted,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.volume_off),
                  const Icon(Icons.push_pin),
                  if (chat.unReadMessageCount > 0)
                    UnreadMessageCount(
                      count: chat.unReadMessageCount,
                      textColor: customColors.background!,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF25D366)
                          : CustomColors.of(context).primary!,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        context.read<ChatRoomBloc>().add(ChatRoomOpen(user: chat.user));
      },
    );
  }

  /// Show user dp in a Dialog widget when pressed on UserDp in ListTile.
  void _showDpDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black38,
      builder: (context) => DPDialog(user: chat.user),
    );
  }

  /// Format DateTime to readable text.
  /// eg: `10:10 AM`, `Friday`, `7/22/2022`.
  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date).inDays;
    if (difference < 1) return DateFormat(DateFormat.HOUR_MINUTE).format(date);
    if (difference < 2) return 'Yesterday';
    if (difference < 7) return DateFormat(DateFormat.WEEKDAY).format(date);
    return DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(date);
  }
}
