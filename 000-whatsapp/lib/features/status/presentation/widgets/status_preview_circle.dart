import 'package:flutter/material.dart';

import '../../../../core/utils/themes/custom_colors.dart';
import '../../status.dart';

/// Leading widget in [StatusTile].
class StatusPreviewCircle extends StatelessWidget {
  const StatusPreviewCircle({
    super.key,
    required this.status,
  });

  final Status status;

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.5,
          color: status.isSeen
              ? customColors.onBackgroundMuted!
              : customColors.primary!,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.5),
        child: CircleAvatar(
          radius: 22,
          backgroundImage: status.content.imgUrl != null
              ? Image.network(
                  status.content.imgUrl!,
                  fit: BoxFit.scaleDown,
                ).image
              : null,
        ),
      ),
    );
  }
}
