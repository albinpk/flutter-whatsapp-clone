import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF0B141A)
          : const Color(0xFFF7F8FA),
      body: IconTheme(
        data: IconThemeData(color: CustomColors.of(context).iconMuted),
        child: CustomScrollView(
          slivers: [
            const _AppBar(),
            const _ProfileHead(),
            const _About(),
            const _Options(),
            const _Options2(),
            const _GroupsInCommon(),
            const _BlockAndReport(),
            // Bottom padding
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Builder(
        builder: (context) => Text(
          context.select((WhatsAppUser user) => user.name),
        ),
      ),
    );
  }
}

class _ProfileHead extends StatelessWidget {
  const _ProfileHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            const UserDP(radius: 55),
            const SizedBox(height: 10),
            Text(
              context.select((WhatsAppUser user) => user.name),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              context.select((WhatsAppUser user) => user.phNumber),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 20),
            IconTheme(
              data: IconThemeData(
                color: CustomColors.of(context).primary,
                size: 30,
              ),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: CustomColors.of(context).primary,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        Icon(Icons.call),
                        SizedBox(height: 15),
                        Text('Audio'),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(Icons.videocam),
                        SizedBox(height: 15),
                        Text('Video'),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(Icons.currency_rupee),
                        SizedBox(height: 15),
                        Text('Pay'),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(height: 15),
                        Text('Search'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.select((WhatsAppUser user) => user.about),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 3),
            Text(
              'August 12',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: CustomColors.of(context).onBackgroundMuted,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          SwitchListTile(
            value: false,
            onChanged: (v) {},
            secondary: const Icon(Icons.notifications),
            title: const Text('Mute notifications'),
          ),
          const ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Custom notification'),
          ),
          const ListTile(
            leading: Icon(Icons.image),
            title: Text('Media visibility'),
          ),
          const ListTile(
            leading: Icon(Icons.currency_rupee),
            title: Text('Payments'),
          ),
        ],
      ),
    );
  }
}

class _Options2 extends StatelessWidget {
  const _Options2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: const [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Encryption'),
            isThreeLine: true,
            subtitle: Text(
              'Messages and calls are end-to-end encrypted. Tap to verify.',
            ),
          ),
          ListTile(
            leading: Icon(Icons.av_timer_outlined),
            title: Text('Disappearing messages'),
            subtitle: Text('Off'),
          ),
        ],
      ),
    );
  }
}

class _GroupsInCommon extends StatelessWidget {
  const _GroupsInCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'No groups in common',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: customColors.onBackgroundMuted,
                  ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: customColors.primary,
              foregroundColor: Colors.white,
              child: const Icon(Icons.group),
            ),
            title: Builder(
              builder: (context) {
                return Text(
                  'Create group with '
                  '${context.select((WhatsAppUser user) => user.name)}',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _BlockAndReport extends StatelessWidget {
  const _BlockAndReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = context.select((WhatsAppUser user) => user.name);
    final color = Theme.of(context).colorScheme.error;
    return _Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.block),
            title: Text('Block $name'),
            iconColor: color,
            textColor: color,
          ),
          ListTile(
            leading: const Icon(Icons.thumb_down),
            title: Text('Report $name'),
            iconColor: color,
            textColor: color,
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        // To remove default border radius
        shape: const RoundedRectangleBorder(),
        color: CustomColors.of(context).background,
        margin: const EdgeInsets.only(bottom: 15),
        child: child,
      ),
    );
  }
}
