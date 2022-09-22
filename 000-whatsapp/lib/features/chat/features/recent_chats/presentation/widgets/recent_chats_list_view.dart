import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/platform_type.dart';
import 'recent_chats_list_tile.dart';

class RecentChatsListView extends StatelessWidget {
  const RecentChatsListView({Key? key}) : super(key: key);

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
        : ListView.separated(
            separatorBuilder: (_, __) => const Divider(height: 0, indent: 80),
            itemCount: friendsLength,
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
