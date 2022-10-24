import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({
    super.key,
    required this.status,
  });

  final Status status;

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with SingleTickerProviderStateMixin {
  /// Controller for status progress bar animation.
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  @override
  void initState() {
    super.initState();
    _controller
      ..forward()
      ..addStatusListener(_animationStatusListener);
  }

  /// Pop the screen when animation completed.
  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// Timer for detect normal and long tap.

  // Pop the screen on normal tap.
  // If it is long tap then stop the animation,
  // and forward it when tapUp on tapCancel detected.
  Timer? _timer;
  bool _isLong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: _AppBar(
        status: widget.status,
        animation: _controller,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _onTapDown,
        onTapUp: _onTapUpOrCancel,
        onTapCancel: _onTapUpOrCancel,

        // Status image
        child: Center(
          child: Image.network(widget.status.content.imgUrl!),
        ),
      ),
    );
  }

  // Stop the animation and start the timer.
  void _onTapDown(_) {
    _controller.stop();
    _timer = Timer(
      const Duration(milliseconds: 100),
      () => _isLong = true,
    );
  }

  // Forward the animation if its long tap,
  // otherwise pop the screen.
  void _onTapUpOrCancel([_]) {
    if (_isLong) {
      _controller.forward();
      _isLong = false;
    } else {
      _timer!.cancel();
      Navigator.of(context).pop();
    }
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.status,
    required this.animation,
  }) : super(key: key);

  final Status status;

  /// Progress bar animation.
  final Animation<double> animation;

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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: const ColoredBox(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          AppBar(
            // Elevation for text visibility on white screen
            elevation: 0.1,
            shadowColor: Colors.black26,
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
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
