import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/target_platform.dart';

class StatusProgressBar extends StatelessWidget {
  const StatusProgressBar({
    super.key,
    required this.animation,
  });

  /// Progress bar animation.
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Theme.of(context).platform.isMobile ? 2 : 5,
      width: MediaQuery.of(context).size.width - 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Status progress bar background
            const ColoredBox(color: Colors.white30),
            // Status progress bar
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  heightFactor: 1,
                  widthFactor: animation.value,
                  child: child,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: const ColoredBox(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
