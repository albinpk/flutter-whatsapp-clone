import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/extensions/platform_type.dart';
import '../widgets/chats_list_app_bar.dart';
import '../widgets/chats_list_tile.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _ChatsViewMobile()
        : const _ChatsViewDesktop();
  }
}

class _ChatsViewMobile extends StatelessWidget {
  const _ChatsViewMobile({Key? key}) : super(key: key);

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
          const SliverPadding(
            padding: EdgeInsets.only(top: 6, bottom: 83),
            sliver: _FriendsListView(),
          ),
        ],
      ),
    );
  }
}

class _ChatsViewDesktop extends StatelessWidget {
  const _ChatsViewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatsListAppBar(),
      body: _FriendsListView(),
    );
  }
}

class _FriendsListView extends StatelessWidget {
  const _FriendsListView({Key? key}) : super(key: key);

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
        .read<List<User>>()
        .singleWhere((user) => user.id == currentFriendId);
    return ChatsListTile(user: user);
  }
}
