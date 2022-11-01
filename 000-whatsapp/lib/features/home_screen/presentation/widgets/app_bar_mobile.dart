import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../chat/chat.dart';
import '../../../settings/settings.dart';
import '../../../status/status.dart';
import '../../home_screen.dart';

class AppBarMobile extends StatelessWidget {
  const AppBarMobile({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final customColors = CustomColors.of(context);

    final isChatSearchOpen = context.select(
      (ChatSearchBloc bloc) => bloc.state is ChatSearchOpenState,
    );

    if (isChatSearchOpen) return const SearchBarMobile();

    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      foregroundColor: isLight ? null : customColors.onBackgroundMuted,
      title: const Text('WhatsApp'),
      floating: true,
      pinned: true,
      snap: true,
      forceElevated: true,
      actions: [
        // Search icon
        IconButton(
          onPressed: () {
            switch (context.read<TabViewBloc>().state.tabView) {
              case TabView.chats:
                context.read<ChatSearchBloc>().add(const ChatSearchOpen());
                break;
              case TabView.status:
              case TabView.calls:
            }
          },
          icon: const Icon(Icons.search),
        ),

        // More icon
        PopupMenuButton<_PopupMenu>(
          itemBuilder: (context) => _popupMenuItems,
          // Increasing PopupMenu width using constrains
          constraints: const BoxConstraints(minWidth: 190),
          onSelected: (menu) {
            switch (menu) {
              case _PopupMenu.newGroup:
              case _PopupMenu.newBroadcast:
              case _PopupMenu.linkedDevices:
              case _PopupMenu.starredMessages:
              case _PopupMenu.payments:
                break;
              case _PopupMenu.settings:
                context.read<SettingsBloc>().add(const SettingsScreenOpen());
                break;
            }
          },
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        indicatorWeight: 3,
        labelColor: theme.indicatorColor,
        labelStyle: theme.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: isLight ? null : customColors.onBackgroundMuted,
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('CHATS'),

                // Unread chats count
                Builder(
                  builder: (context) {
                    final unreadCount = context.select(
                      (ChatBloc bloc) => bloc.state.recentChats
                          .where((c) => c.unReadMessageCount > 0)
                          .length,
                    );

                    if (unreadCount == 0) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: UnreadMessageCount(
                        count: unreadCount,
                        textColor: customColors.secondary!,
                        color: isLight ? Colors.white : customColors.primary!,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('STATUS'),

                // Recent statuses label
                Builder(
                  builder: (context) {
                    final haveRecentStatus = context.select(
                      (StatusBloc bloc) => bloc.state.recent.isNotEmpty,
                    );

                    if (!haveRecentStatus) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: ColoredCircle(
                        dimension: 6,
                        color: isLight ? Colors.white : customColors.primary!,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Tab(child: Text('CALLS')),
        ],
      ),
    );
  }

  /// Popup menu items.
  static const _popupMenuItems = [
    PopupMenuItem<_PopupMenu>(
      enabled: false,
      value: _PopupMenu.newGroup,
      child: Text('New group'),
    ),
    PopupMenuItem<_PopupMenu>(
      enabled: false,
      value: _PopupMenu.newBroadcast,
      child: Text('New broadcast'),
    ),
    PopupMenuItem<_PopupMenu>(
      enabled: false,
      value: _PopupMenu.linkedDevices,
      child: Text('Linked devices'),
    ),
    PopupMenuItem<_PopupMenu>(
      enabled: false,
      value: _PopupMenu.starredMessages,
      child: Text('Starred messages'),
    ),
    PopupMenuItem<_PopupMenu>(
      enabled: false,
      value: _PopupMenu.payments,
      child: Text('Payments'),
    ),
    PopupMenuItem<_PopupMenu>(
      value: _PopupMenu.settings,
      child: Text('Settings'),
    ),
  ];
}

/// Values for PopupMenuItem.
enum _PopupMenu {
  newGroup,
  newBroadcast,
  linkedDevices,
  starredMessages,
  payments,
  settings,
}
