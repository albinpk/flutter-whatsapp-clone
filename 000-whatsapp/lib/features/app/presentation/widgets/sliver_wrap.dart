import 'package:flutter/material.dart';

import '../../../chats/presentation/views/chats_view.dart';
import 'app_bar_with_tabs.dart';

class SliverWrap extends StatelessWidget {
  const SliverWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: AppBarWithTabs(forceElevated: innerBoxIsScrolled),
            ),
          ],
          body: const TabBarView(
            children: [
              ChatsView(),
              Center(child: Text('STATUS')),
              Center(child: Text('CALLS')),
            ],
          ),
        ),
      ),
    );
  }
}
