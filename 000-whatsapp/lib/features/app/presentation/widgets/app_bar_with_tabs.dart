import 'package:flutter/material.dart';

class AppBarWithTabs extends StatelessWidget {
  const AppBarWithTabs({
    super.key,
    required this.forceElevated,
  });

  final bool forceElevated;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('WhatsApp'),
      floating: true,
      pinned: true,
      snap: true,
      forceElevated: forceElevated,
      bottom: const TabBar(
        tabs: [
          Tab(text: 'CHATS'),
          Tab(text: 'STATUS'),
          Tab(text: 'CALLS'),
        ],
      ),
    );
  }
}
