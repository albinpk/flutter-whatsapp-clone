import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({
    super.key,
    required this.status,
  });

  final Status status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _AppBar(status: status),
      body: Center(
        child: Image.network(status.content.imgUrl!),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.status,
  }) : super(key: key);

  final Status status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Column with status progress bar and appBar
      child: Column(
        children: [
          // Status progress
          SizedBox(
            height: 2,
            width: MediaQuery.of(context).size.width - 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                fit: StackFit.expand,
                children: const [
                  // Status progress bar background
                  ColoredBox(color: Colors.white30),
                  // Status progress bar
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    heightFactor: 1,
                    widthFactor: 0.5,
                    child: ColoredBox(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            title: Row(
              children: [
                const UserDP(),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(status.author.name),
                    Text(
                      DateFormat(DateFormat.HOUR_MINUTE).format(status.time),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);
}
