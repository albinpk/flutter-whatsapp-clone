import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/chat.dart';
import '../../../../core/utils/themes/custom_colors.dart';
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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
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
}
