import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/user_model.dart';
import '../../../../../../utils/extensions/platform_type.dart';
import '../../../../../../utils/themes/custom_colors.dart';
import '../../../../bloc/chats_bloc.dart';

class ChatRoomAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatRoomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    return AppBar(
      leadingWidth: 70,
      titleSpacing: 0,
      foregroundColor: Colors.white,
      leading: isMobile ? const _Leading() : null,
      title: const _Title(),
      actionsIconTheme: IconThemeData(
        color: CustomColors.of(context).onSecondary,
      ),
      actions: [
        if (isMobile) ...[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
        ] else
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        const _PopupMenu()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Leading extends StatelessWidget {
  const _Leading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () {
            context
                .read<ChatsBloc>()
                .add(const ChatsScreenCloseButtonPressed());
          },
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: const [
                Flexible(
                  flex: 3,
                  child: FittedBox(
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: CircleAvatar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Theme.of(context).platform.isDesktop)
          const Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.select((User user) => user.name),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: CustomColors.of(context).onSecondary,
                  ),
            ),
            Text(
              'Last seen..',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CustomColors.of(context).onSecondaryMuted,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PopupMenu extends StatelessWidget {
  const _PopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Theme.of(context).platform.isDesktop;
    return PopupMenuButton(
      itemBuilder: (context) => [
        if (isDesktop)
          PopupMenuItem(
            onTap: () {
              context
                  .read<ChatsBloc>()
                  .add(const ChatsScreenCloseButtonPressed());
            },
            child: const Text('Close chat'),
          ),
      ],
    );
  }
}
