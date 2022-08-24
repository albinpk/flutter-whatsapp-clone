import 'package:flutter/material.dart';

import '../../../chats/presentation/views/chats_view.dart';

class SliverWrap extends StatelessWidget {
  const SliverWrap({super.key});

  static const _tabs = ['CHATS', 'STATUS', 'CALLS'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('WhatsApp'),
                floating: true,
                pinned: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: _tabs.map((t) => Tab(text: t)).toList(),
                ),
              ),
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
