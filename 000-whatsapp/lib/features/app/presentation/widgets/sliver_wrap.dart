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
          headerSliverBuilder: (context, _) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: const AppBarWithTabs(),
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message),
          onPressed: () {},
        ),
      ),
    );
  }
}
