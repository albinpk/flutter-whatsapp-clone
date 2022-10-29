import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({
    super.key,
    required this.status,
    required this.pageController,
  });

  final Status status;

  /// The [StatusPageView] controller.
  ///
  /// To stop animation on page scroll.
  final PageController pageController;

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
    _controller.addStatusListener(_animationStatusListener);
    widget.pageController.addListener(_pageListener);
  }

  /// Show next status when animation completed.
  /// If it is the last status then pop the screen.
  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (widget.pageController.page! ==
          context.read<StatusBloc>().state.statuses.length - 1) {
        Navigator.of(context).pop();
      } else {
        widget.pageController.nextPage(
          duration: kTabScrollDuration,
          curve: Curves.ease,
        );
      }
    }
  }

  void _pageListener() {
    if (widget.pageController.page! - widget.pageController.page!.floor() !=
        0) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    widget.pageController.removeListener(_pageListener);
    _tapDetectorTimer?.cancel();
    _appBarVisible.dispose();
    _appBarVisibilityTimer?.cancel();
    super.dispose();
  }

  /// Timer for detect normal and long tap.

  // Pop the screen on normal tap.
  // If it is long tap then stop the animation,
  // and forward it when tapUp on tapCancel detected.
  Timer? _tapDetectorTimer;
  bool _isLong = false;

  /// Whether appBar visible or not.
  ///
  /// AppBar is hidden after long press for 500 milliseconds.
  final _appBarVisible = ValueNotifier<bool>(true);

  /// Timer for hide appBar after long tap.
  Timer? _appBarVisibilityTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        // +2 for status progress bar
        preferredSize: const Size.fromHeight(kToolbarHeight + 2),
        child: ValueListenableBuilder<bool>(
          valueListenable: _appBarVisible,
          builder: (context, isVisible, child) {
            // Use IgnorePointer to ignore back button tap when appBar is hidden
            return IgnorePointer(
              ignoring: !isVisible,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                opacity: isVisible ? 1 : 0,
                child: child,
              ),
            );
          },
          child: _AppBar(
            status: widget.status,
            animation: _controller,
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _onTapDown,
        onTapUp: _onTapUpOrCancel,
        onTapCancel: _onTapUpOrCancel,

        // Status image
        child: Center(
          child: VisibilityDetector(
            key: ValueKey(widget.status.id),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 1) {
                _controller.forward();
                if (!widget.status.isSeen) {
                  context
                      .read<StatusBloc>()
                      .add(StatusViewed(status: widget.status));
                }
              }
            },
            child: Image.network(widget.status.content.imgUrl!),
          ),
        ),
      ),
    );
  }

  void _onTapDown(_) {
    // Stop the animation and start the timer for detect tap
    _controller.stop();
    _tapDetectorTimer = Timer(
      const Duration(milliseconds: 100),
      () => _isLong = true,
    );

    // Start timer to hide appBar
    _appBarVisibilityTimer = Timer(
      const Duration(milliseconds: 500),
      () => _appBarVisible.value = false,
    );
  }

  void _onTapUpOrCancel([_]) {
    // Show appBar
    if (_appBarVisible.value) {
      _appBarVisibilityTimer!.cancel();
    } else {
      _appBarVisible.value = true;
    }

    // Forward the animation if its long tap,
    // otherwise pop the screen.
    if (_isLong) {
      _controller.forward();
      _isLong = false;
    } else {
      _tapDetectorTimer!.cancel();
      Navigator.of(context).pop();
    }
  }
}

class _AppBar extends StatelessWidget {
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
          StatusProgressBar(animation: animation),

          AppBar(
            // Elevation for text visibility on white screen
            elevation: 0.1,
            shadowColor: Colors.black26,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            title: Row(
              children: [
                UserDP(url: status.author.dpUrl),
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
}
