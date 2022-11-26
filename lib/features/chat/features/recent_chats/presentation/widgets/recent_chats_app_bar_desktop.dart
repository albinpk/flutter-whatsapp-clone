import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../settings/settings.dart';
import '../../../../../status/status.dart';
import '../../../new_chat/new_chat.dart';
import '../../../search/search.dart';

class RecentChatsAppBarDesktop extends StatelessWidget
    with PreferredSizeWidget {
  const RecentChatsAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    const actionsIconPadding = EdgeInsets.symmetric(horizontal: 15);
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: FittedBox(
          child: GestureDetector(
            onTap: () {
              context
                  .read<ProfileSettingsBloc>()
                  .add(const ProfileSettingsOpen());
            },
            child: UserDP(
              url: context.select((User u) => u.dpUrl),
            ),
          ),
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: Theme.of(context).brightness == Brightness.light
            ? CustomColors.of(context).onBackgroundMuted
            : CustomColors.of(context).iconMuted,
      ),
      actions: [
        // Status icon
        IconButton(
          onPressed: () => context.read<StatusListViewCubit>().push(),
          icon: const Icon(Icons.donut_large_rounded),
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
          position: PopupMenuPosition.under,
          padding: actionsIconPadding,
          onSelected: (menu) {
            switch (menu) {
              case _PopupMenu.newGroup:
              case _PopupMenu.starredMessages:
                break;
              case _PopupMenu.settings:
                context.read<SettingsBloc>().add(const SettingsScreenOpen());
                break;
              case _PopupMenu.logout:
                break;
            }
          },
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
