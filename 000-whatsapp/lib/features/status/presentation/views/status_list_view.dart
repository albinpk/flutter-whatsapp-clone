import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusListView extends StatelessWidget {
  const StatusListView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
          const UserDP(radius: 25),
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
