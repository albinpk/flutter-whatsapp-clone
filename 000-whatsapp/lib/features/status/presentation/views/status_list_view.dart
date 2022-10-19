import 'package:flutter/material.dart';

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
        const SliverToBoxAdapter(child: ListSectionTitle('Recent updates')),

        // Status list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return const StatusTile(
                leading: StatusPreviewCircle(),
                title: 'User',
                subtitle: 'Just now',
              );
            },
            childCount: 1,
          ),
        )
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
