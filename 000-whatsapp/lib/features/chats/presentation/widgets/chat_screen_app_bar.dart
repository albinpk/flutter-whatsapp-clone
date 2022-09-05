import 'package:flutter/material.dart';

class ChatScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      titleSpacing: 0,
      foregroundColor: Colors.white,
      leading: const _Leading(),
      title: const _Title(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.videocam_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.call),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
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
          onTap: Navigator.of(context).pop,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('User name'),
        Text(
          'Last seen..',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
