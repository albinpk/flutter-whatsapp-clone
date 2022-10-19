import 'package:flutter/material.dart';

import '../../../../core/utils/themes/custom_colors.dart';
import '../../../../core/widgets/widgets.dart';
import 'status_tile.dart';

/// Leading widget in [StatusTile].
class StatusPreviewCircle extends StatelessWidget {
  const StatusPreviewCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.5,
          color: CustomColors.of(context).primary!,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Padding(
        padding: EdgeInsets.all(4.5),
        child: UserDP(radius: 22),
      ),
    );
  }
}
