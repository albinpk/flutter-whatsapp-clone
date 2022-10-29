import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/models.dart';
import '../../../../core/utils/extensions/target_platform.dart';
import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusListView extends StatelessWidget {
  const StatusListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? const _StatusListViewMobile()
        : const _StatusListViewDesktop();
  }
}

class _StatusListViewMobile extends StatelessWidget {
  const _StatusListViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _StatusList();
  }
}

class _StatusListViewDesktop extends StatelessWidget {
  const _StatusListViewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customColors = CustomColors.of(context);
    return Scaffold(
      body: Row(
        children: [
          // Status list
          const Expanded(
            flex: 2,
            child: _StatusList(),
          ),

          // Right side of screen with close button
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 15),
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        iconSize: 30,
                        onPressed: () {
                          context.read<StatusListViewCubit>().pop();
                        },
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.donut_large_rounded,
                          size: 80,
                          color: customColors.onBackgroundMuted,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Click on a contact to view their status updates',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: customColors.onBackgroundMuted,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusList extends StatelessWidget {
  const _StatusList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (Theme.of(context).platform.isMobile)
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),

        // My status / Add status
        const SliverToBoxAdapter(child: _MyStatusTile()),

        // List title
        SliverToBoxAdapter(
          child: Builder(builder: (context) {
            if (context
                .select((StatusBloc bloc) => bloc.state.statuses.isEmpty)) {
              return const ListSectionTitle('No recent updates');
            }
            if (context
                .select((StatusBloc bloc) => bloc.state.recent.isNotEmpty)) {
              return const ListSectionTitle('Recent updates');
            }
            return const ListSectionTitle('Viewed updates');
          }),
        ),

        // Recent status list
        Builder(builder: (context) {
          final statusList = context.select(
            (StatusBloc bloc) => bloc.state.recent,
          );
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: statusList.length,
              (context, index) => StatusTile.fromStatus(statusList[index]),
            ),
          );
        }),

        // List title
        Builder(
          builder: (context) {
            return SliverToBoxAdapter(
              child: context.select((StatusBloc bloc) =>
                      bloc.state.viewed.isNotEmpty &&
                      bloc.state.recent.isNotEmpty)
                  ? const ListSectionTitle('Viewed updates')
                  : const SizedBox.shrink(),
            );
          },
        ),

        // Viewed status list
        Builder(builder: (context) {
          final statusList = context.select(
            (StatusBloc bloc) => bloc.state.viewed,
          );
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: statusList.length,
              (context, index) => StatusTile.fromStatus(statusList[index]),
            ),
          );
        }),
      ],
    );
  }
}

class _MyStatusTile extends StatelessWidget {
  const _MyStatusTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusTile(
      onTap: () {},
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          UserDP(
            radius: 25,
            url: context.select((User u) => u.dpUrl),
          ),
          if (Theme.of(context).platform.isMobile)
            ColoredCircle(
              color: CustomColors.of(context).primary!,
              child: const FittedBox(
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
        ],
      ),
      title: 'My status',
      subtitle: 'Tap to add status update',
    );
  }
}
