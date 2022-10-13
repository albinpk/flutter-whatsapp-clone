import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/chat.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../settings/settings.dart';
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

    return BlocBuilder<ChatSearchBloc, ChatSearchState>(
      buildWhen: (previous, current) {
        return current is ChatSearchOpenState ||
            current is ChatSearchCloseState;
      },
      builder: (context, state) {
        if (state is ChatSearchOpenState) {
          return const SearchBarMobile();
        }

        return SliverAppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          foregroundColor: theme.brightness == Brightness.dark
              ? CustomColors.of(context).onBackgroundMuted
              : null,
          title: const Text('WhatsApp'),
          floating: true,
          pinned: true,
          snap: true,
          forceElevated: true,
          actions: [
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
            PopupMenuButton<_PopupMenu>(
              onSelected: (menu) {
                switch (menu) {
                  case _PopupMenu.settings:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: _buildPopupMenuItems,
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            indicatorWeight: 3,
            labelColor: theme.indicatorColor,
            labelStyle: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: theme.brightness == Brightness.dark
                ? CustomColors.of(context).onBackgroundMuted
                : null,
            tabs: const [
              Tab(child: Text('CHATS')),
              Tab(child: Text('STATUS')),
              Tab(child: Text('CALLS')),
            ],
          ),
        );
      },
    );
  }

  List<PopupMenuEntry<_PopupMenu>> _buildPopupMenuItems(BuildContext context) {
    return [
      'New group',
      'New broadcast',
      'Linked devices',
      'Starred messages',
      'Payments',
    ]
        .map((e) => PopupMenuItem<_PopupMenu>(enabled: false, child: Text(e)))
        .followedBy(
      const [
        PopupMenuItem<_PopupMenu>(
          value: _PopupMenu.settings,
          child: Text('Settings'),
        ),
      ],
    ).toList();
  }
}

/// Popup menu items.
enum _PopupMenu {
  settings,
}
