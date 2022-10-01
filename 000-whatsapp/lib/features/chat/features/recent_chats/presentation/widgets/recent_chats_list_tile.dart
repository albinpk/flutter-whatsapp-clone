import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/platform_type.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
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

    bool isSelected = false;
    if (theme.platform.isDesktop) {
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
      leading: const UserDP(radius: 25),
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
            DateFormat(DateFormat.HOUR_MINUTE).format(chat.lastMessage.time),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            // Last message
            Expanded(
              child: Row(
                children: [
                  // Message status
                  if (chat.lastMessage.author == context.watch<User>())
                    MessageStatusIcon(
                      status: chat.lastMessage.status,
                      color: lastMessageTextStyle.color!,
                    ),
                  Text(
                    chat.lastMessage.content.text,
                    style: lastMessageTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

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
                    _UnreadMessageBadge(count: chat.unReadMessageCount),
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
}

class _UnreadMessageBadge extends StatelessWidget {
  const _UnreadMessageBadge({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      // Use size of other icons in ChatsListTile
      dimension: IconTheme.of(context).size,
      child: ClipOval(
        child: ColoredBox(
          color: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFF25D366)
              : CustomColors.of(context).primary!,
          child: Center(
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
