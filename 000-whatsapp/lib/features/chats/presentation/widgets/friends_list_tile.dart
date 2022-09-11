import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/themes/custom_colors.dart';
import '../../bloc/chats_bloc.dart';

class FriendsListTile extends StatelessWidget {
  const FriendsListTile({super.key});

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
                    color: CustomColors.of(context).onBackground,
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
        final user = context.read<User>();
        return context.read<ChatsBloc>().add(ChatsTilePressed(user: user));
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
