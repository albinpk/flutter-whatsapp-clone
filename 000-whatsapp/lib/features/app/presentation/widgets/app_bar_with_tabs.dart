import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWithTabs extends StatelessWidget {
  const AppBarWithTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      title: const Text('WhatsApp'),
      floating: true,
      pinned: true,
      snap: true,
      elevation: 1,
      forceElevated: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
      bottom: const TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(text: 'CHATS'),
          Tab(text: 'STATUS'),
          Tab(text: 'CALLS'),
        ],
      ),
    );
  }
}
