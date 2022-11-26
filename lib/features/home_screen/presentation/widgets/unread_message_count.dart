import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';

class UnreadMessageCount extends StatelessWidget {
  /// Unread message count badge.
  const UnreadMessageCount({
    super.key,
    required this.count,
    required this.textColor,
    required this.color,
  });

  /// Message count.
  final int count;

  /// Count text color.
  final Color textColor;

  /// Background color for badge.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredCircle(
      color: color,
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: textColor,
              fontSize: 11,
            ),
      ),
    );
  }
}
