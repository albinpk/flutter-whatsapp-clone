import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/themes/custom_colors.dart';

class AppBarMobile extends StatelessWidget {
  const AppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
  }
}
