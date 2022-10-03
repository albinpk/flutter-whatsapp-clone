import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../chat.dart';

class RecentChatsView extends StatelessWidget {
  const RecentChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _RecentChatsViewMobile()
        : const _RecentChatsViewDesktop();
  }
}

class _RecentChatsViewMobile extends StatefulWidget {
  const _RecentChatsViewMobile({Key? key}) : super(key: key);

  @override
  State<_RecentChatsViewMobile> createState() => _RecentChatsViewMobileState();
}

class _RecentChatsViewMobileState extends State<_RecentChatsViewMobile> {
  late ScrollController _scrollController;
  double _scrollOffsetOnSearchOpen = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = PrimaryScrollController.of(context)!;
    final state = context.read<ChatSearchBloc>().state;
    if (state is ChatSearchOpenState) {
      // Check scrollController.hasClients,
      // otherwise get "ScrollController not attached to any scroll views"
      // error when scrolling on other TabBarViews
      if (_scrollController.hasClients) {
        _scrollOffsetOnSearchOpen = _scrollController.offset;
      }
      _scrollController.addListener(_scrollListener);
    } else if (state is ChatSearchCloseState) {
      _scrollController.removeListener(_scrollListener);
    }
  }

  void _scrollListener() {
    if ((_scrollController.offset - _scrollOffsetOnSearchOpen).abs() > 20) {
      context.read<ChatSearchBloc>().add(const ChatSearchClose());
      _scrollController.removeListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    // Don't dispose _scrollController.
    // because it is NestedScrollView's controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select((ChatSearchBloc bloc) => bloc.state is ChatSearchOpenState);
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey('chats-view-key'),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          if (context.select((ChatBloc bloc) => bloc.state.recentChats.isEmpty))
            const SliverFillRemaining(
              hasScrollBody: false,
              child: NoRecentChatsFound(),
            )
          else
            const SliverPadding(
              padding: EdgeInsets.only(top: 6, bottom: 83),
              sliver: RecentChatsListView(),
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
      body: context.select((ChatBloc bloc) => bloc.state.recentChats.isEmpty)
          ? const NoRecentChatsFound()
          : const RecentChatsListView(),
    );
  }
}
