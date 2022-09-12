import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/platform_type.dart';
import '../../bloc/chats_bloc.dart';
import '../views/users_view.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatsBloc>().add(const ChatsContactsScreenPopped());
        return false;
      },
      child: Scaffold(
        appBar: _AppBar(isMobile: Theme.of(context).platform.isMobile),
        body: const UsersView(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          context.read<ChatsBloc>().add(const ChatsContactsScreenPopped());
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(isMobile ? 'Select contact' : 'New chat'),
      actions: !isMobile
          ? null
          : [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
    );

    return isMobile
        ? appBar
        : AppBar(
            bottom: appBar,
            automaticallyImplyLeading: false,
          );
  }

  @override
  Size get preferredSize => isMobile
      ? const Size.fromHeight(kToolbarHeight)
      : const Size.fromHeight(kToolbarHeight * 2);
}
