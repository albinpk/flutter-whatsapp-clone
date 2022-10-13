import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../new_chat/new_chat.dart';
import '../../../search/search.dart';

class RecentChatsAppBarDesktop extends StatelessWidget
    with PreferredSizeWidget {
  const RecentChatsAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    const actionsIconPadding = EdgeInsets.symmetric(horizontal: 15);
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: FittedBox(child: UserDP()),
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).brightness == Brightness.light
            ? CustomColors.of(context).onBackgroundMuted
            : CustomColors.of(context).iconMuted,
      ),
      actions: [
        // Search icon
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.circle_outlined),
          padding: actionsIconPadding,
        ),

        // New chat icon
        IconButton(
          onPressed: () {
            context.read<NewChatBloc>().add(const NewChatSelectionScreenOpen());
          },
          icon: const Icon(Icons.message),
          padding: actionsIconPadding,
        ),

        // More icon
        PopupMenuButton<_PopupMenu>(
          itemBuilder: (context) => _popupMenuItems,
          offset: const Offset(-135, 0),
          position: PopupMenuPosition.under,
          padding: actionsIconPadding,
        )
      ],
      bottom: const SearchBarDesktop(),
    );
  }

  /// Popup menu items.
  static const _popupMenuItems = [
    PopupMenuItem(
      enabled: false,
      value: _PopupMenu.newGroup,
      child: Text('New group'),
    ),
    PopupMenuItem(
      enabled: false,
      value: _PopupMenu.starredMessages,
      child: Text('Starred messages'),
    ),
    PopupMenuItem(
      enabled: false,
      value: _PopupMenu.settings,
      child: Text('Settings'),
    ),
    PopupMenuItem(
      enabled: false,
      value: _PopupMenu.logout,
      child: Text('Log out'),
    ),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

/// Values for PopupMenuItem.
enum _PopupMenu {
  newGroup,
  starredMessages,
  settings,
  logout,
}
