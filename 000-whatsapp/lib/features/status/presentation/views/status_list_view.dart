import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        const SliverToBoxAdapter(child: _MyStatusTile()),
        SliverToBoxAdapter(
          child: Builder(builder: (context) {
            if (context
                .select((StatusBloc bloc) => bloc.state.statuses.isEmpty)) {
              return const ListSectionTitle('No recent updates');
            }
            return const ListSectionTitle('Recent updates');
          }),
        ),

        // Status list
        Builder(builder: (context) {
          final statusList = context.select(
            (StatusBloc bloc) => bloc.state.statuses,
          );
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: statusList.length,
              (context, index) {
                final status = statusList[index];
                return StatusTile(
                  leading: StatusPreviewCircle(status: status),
                  title: status.author.name,
                  subtitle:
                      DateFormat(DateFormat.HOUR_MINUTE).format(status.time),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StatusScreen(status: status),
                      ),
                    );
                  },
                );
              },
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
