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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Builder(
              builder: (context) => Text(
                context.select((WhatsAppUser user) => user.name),
              ),
            ),
          ),
          const _ProfileHead(),
          const _Divider(),
          const _About(),
          const _Divider(),
          const _Divider(),
        ],
      ),
    );
  }
}

class _ProfileHead extends StatelessWidget {
  const _ProfileHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    return SliverToBoxAdapter(
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

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Divider(
        height: 15,
        thickness: 15,
        color: CustomColors.of(context).chatRoomBackground,
      ),
    );
  }
}
