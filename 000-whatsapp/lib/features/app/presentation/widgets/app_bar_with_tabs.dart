import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWithTabs extends StatelessWidget {
  const AppBarWithTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      bottom: TabBar(
        indicatorWeight: 3,
        labelColor: theme.indicatorColor,
        labelStyle: theme.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: theme.brightness == Brightness.light
            ? null
            : theme.colorScheme.onSurface,
        tabs: const [
          Tab(child: Text('CHATS')),
          Tab(child: Text('STATUS')),
          Tab(child: Text('CALLS')),
        ],
      ),
    );
  }
}
