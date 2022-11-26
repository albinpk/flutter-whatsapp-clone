import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/whats_app_user_model.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../chat.dart';

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
            context.read<ChatRoomBloc>().add(const ChatRoomClose());
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.all(4).copyWith(left: 0),
            child: Row(
              children: [
                const Flexible(
                  flex: 3,
                  child: FittedBox(
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: FittedBox(
                    child: Hero(
                      tag: context.select((WhatsAppUser user) => user.id),
                      child: UserDP(
                        url: context.select((WhatsAppUser u) => u.dpUrl),
                      ),
                    ),
                  ),
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
    return InkWell(
      onTap: () {
        context.read<UserProfileBloc>().add(
              UserProfileOpen(
                user: context.read<WhatsAppUser>(),
              ),
            );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            if (Theme.of(context).platform.isDesktop)
              Padding(
                padding: const EdgeInsets.all(10),
                child: UserDP(
                  url: context.select((WhatsAppUser u) => u.dpUrl),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.select((WhatsAppUser user) => user.name),
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
        ),
      ),
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
              context.read<ChatRoomBloc>().add(const ChatRoomClose());
            },
            child: const Text('Close chat'),
          ),
      ],
    );
  }
}
