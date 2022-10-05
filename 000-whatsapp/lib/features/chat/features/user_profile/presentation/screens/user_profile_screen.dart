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
      child: Column(
        children: [
          const SizedBox(height: 10),
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
    );
  }
}
