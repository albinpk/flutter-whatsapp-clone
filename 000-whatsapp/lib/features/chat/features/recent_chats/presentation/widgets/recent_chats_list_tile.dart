import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    bool isSelected = false;
    if (Theme.of(context).platform.isDesktop) {
      // To highlight selected chat on desktop
      isSelected = context.select(
        (ChatRoomBloc bloc) {
          return bloc.state is ChatRoomOpenState &&
              (bloc.state as ChatRoomOpenState).user == chat.user;
        },
      );
    }

    return ListTile(
      selected: isSelected,
      selectedTileColor: CustomColors.of(context).secondary,
      leading: const UserDP(radius: 25),
      title: Row(
        children: [
          Expanded(
            child: Text(
              chat.user.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.of(context).onBackground,
                  ),
            ),
          ),
          Text(
            chat.lastMessage.time.toString().substring(0, 10),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                chat.lastMessage.content.text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: CustomColors.of(context).onBackgroundMuted,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconTheme(
              data: IconTheme.of(context).copyWith(
                size: 20,
                color: CustomColors.of(context).iconMuted,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.volume_off),
                  Icon(Icons.push_pin),
                  _UnreadMessageBadge(),
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
  const _UnreadMessageBadge({Key? key}) : super(key: key);

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
              '2',
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
