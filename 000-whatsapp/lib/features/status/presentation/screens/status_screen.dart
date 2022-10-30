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
  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _next();
  }

  /// Pause the animation while page swiping.
  void _pageListener() {
    if (widget.pageController.page! - widget.pageController.page!.floor() !=
        0) {
      _pause();
    }
  }

  /// Play/Continue the status progress animation.
  void _play() {
    _controller.forward();
    if (!_appBarVisible.value) {
      _appBarVisible.value = true;
    }
  }

  /// Pause the status progress animation.
  void _pause() => _controller.stop();

  /// Animate to next status page.
  /// If it is the last status then pop the screen.
  void _next() {
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

  /// Whether the appBar is visible or not.
  /// AppBar will hide after long press.
  final _appBarVisible = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _controller.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    widget.pageController.removeListener(_pageListener);
    _appBarVisible.dispose();
    super.dispose();
  }

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
        onTapDown: (_) => _pause(),
        onTapUp: (_) => _next(),
        onLongPress: () => _appBarVisible.value = false,
        onLongPressUp: _play,

        // Status image
        child: Center(
          child: VisibilityDetector(
            key: ValueKey(widget.status.id),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 1) {
                _play();
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
