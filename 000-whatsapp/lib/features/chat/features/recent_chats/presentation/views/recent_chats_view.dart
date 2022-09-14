import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/app_user_model.dart';
import '../../../../../../models/whats_app_user_model.dart';
import '../../../../../../utils/extensions/platform_type.dart';
import '../../../../../../utils/themes/custom_colors.dart';
import '../widgets/recent_chats_app_bar_desktop.dart';
import '../widgets/recent_chats_list_tile.dart';

class RecentChatsView extends StatelessWidget {
  const RecentChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _RecentChatsViewMobile()
        : const _RecentChatsViewDesktop();
  }
}

class _RecentChatsViewMobile extends StatelessWidget {
  const _RecentChatsViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey('chats-view-key'),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          if (context.select((User user) => user.friends.isEmpty))
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _NoRecentChatsFound(),
            )
          else
            const SliverPadding(
              padding: EdgeInsets.only(top: 6, bottom: 83),
              sliver: _RecentChatsListView(),
            ),
        ],
      ),
    );
  }
}

class _RecentChatsViewDesktop extends StatelessWidget {
  const _RecentChatsViewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RecentChatsAppBarDesktop(),
      body: context.select((User user) => user.friends.isEmpty)
          ? const _NoRecentChatsFound()
          : const _RecentChatsListView(),
    );
  }
}

class _RecentChatsListView extends StatelessWidget {
  const _RecentChatsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendsLength = context.select<User, int>(
      (user) => user.friends.length,
    );
    return Theme.of(context).platform.isMobile
        ? SliverFixedExtentList(
            itemExtent: 76,
            delegate: SliverChildBuilderDelegate(
              _itemBuilder,
              childCount: friendsLength,
            ),
          )
        : ListView.builder(
            itemCount: friendsLength,
            itemExtent: 76,
            itemBuilder: _itemBuilder,
          );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final currentFriendId = context.read<User>().friends[index];
    final user = context
        .read<List<WhatsAppUser>>()
        .singleWhere((user) => user.id == currentFriendId);
    return RepositoryProvider.value(
      value: user,
      child: const RecentChatsListTile(),
    );
  }
}

class _NoRecentChatsFound extends StatelessWidget {
  const _NoRecentChatsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Start new chat',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomColors.of(context).onBackgroundMuted,
            ),
      ),
    );
  }
}
