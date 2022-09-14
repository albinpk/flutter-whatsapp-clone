import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/app_user_model.dart';
import '../../../../../../utils/extensions/platform_type.dart';
import '../widgets/widgets.dart';

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
      body: context.select((User user) => user.friends.isEmpty)
          ? const NoRecentChatsFound()
          : const RecentChatsListView(),
    );
  }
}