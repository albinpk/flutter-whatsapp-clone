import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/extensions/platform_type.dart';
import '../../../../utils/themes/custom_colors.dart';
import '../../bloc/chats_bloc.dart';
import '../screens/chat_screen.dart';

class ChatsListTile extends StatelessWidget {
  const ChatsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(radius: 26),
      title: Row(
        children: [
          Expanded(
            child: Text(
              context.select((User user) => user.name),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.of(context).chatsListTileTitle,
                  ),
            ),
          ),
          Text(
            '8/8/22',
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
                'Hi there!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: CustomColors.of(context).chatsListTileSubtitle,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconTheme(
              data: IconTheme.of(context).copyWith(
                size: 20,
                color: CustomColors.of(context).chatsListTileIcon,
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
        final user = context.read<User>();
        return context.read<ChatsBloc>().add(ChatsTilePressed(id: user.id));
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
          color: CustomColors.of(context).chatsListTileBadge!,
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
