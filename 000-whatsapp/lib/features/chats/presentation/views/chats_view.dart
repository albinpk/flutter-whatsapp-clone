import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../widgets/chats_list_tile.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

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
          const SliverPadding(padding: EdgeInsets.only(top: 6)),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ChatsListTile(
                user: context.read<List<User>>().singleWhere(
                    (user) => user.id == context.read<User>().friends[index]),
              ),
              childCount: context.read<User>().friends.length,
            ),
            itemExtent: 76,
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 83)),
        ],
      ),
    );
  }
}
