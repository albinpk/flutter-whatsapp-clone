import 'package:flutter/material.dart';

class ChatsListAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatsListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const actionsIconPadding = EdgeInsets.symmetric(horizontal: 15);
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: CircleAvatar(),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.circle_outlined),
          padding: actionsIconPadding,
        ),
        IconButton(
          onPressed: () {},
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
