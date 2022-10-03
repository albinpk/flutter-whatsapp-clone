import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../chat.dart';

class RecentChatsListView extends StatefulWidget {
  const RecentChatsListView({Key? key}) : super(key: key);

  @override
  State<RecentChatsListView> createState() => _RecentChatsListViewState();
}

class _RecentChatsListViewState extends State<RecentChatsListView> {
  late final _chatBloc = context.read<ChatBloc>();

  @override
  Widget build(BuildContext context) {
    final List<RecentChat> recentChats = context.select(
      (ChatBloc bloc) => bloc.state.recentChats,
    );

    return Theme.of(context).platform.isMobile
        ? SliverFixedExtentList(
            itemExtent: 76,
            delegate: SliverChildBuilderDelegate(
              _itemBuilder,
              childCount: recentChats.length,
            ),
          )
        : ListView.separated(
            separatorBuilder: (_, __) => const Divider(height: 0, indent: 80),
            itemCount: recentChats.length,
            itemBuilder: _itemBuilder,
          );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return RecentChatsListTile(chat: _chatBloc.state.recentChats[index]);
  }
}
