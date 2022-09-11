import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/themes/custom_colors.dart';
import '../../bloc/chats_bloc.dart';

class FriendsListAppBarDesktop extends StatelessWidget
    with PreferredSizeWidget {
  const FriendsListAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    const actionsIconPadding = EdgeInsets.symmetric(horizontal: 15);
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: CircleAvatar(),
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).brightness == Brightness.light
            ? CustomColors.of(context).onBackgroundMuted
            : CustomColors.of(context).iconMuted,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.circle_outlined),
          padding: actionsIconPadding,
        ),
        IconButton(
          onPressed: () {
            context.read<ChatsBloc>().add(const ChatsNewChatButtonPressed());
          },
          icon: const Icon(Icons.message),
          padding: actionsIconPadding,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          padding: actionsIconPadding,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
