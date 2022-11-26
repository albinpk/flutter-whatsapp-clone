import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/utils/extensions/target_platform.dart';
import '../../../../core/widgets/widgets.dart';
import '../../status.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({
    super.key,
    required this.status,
    required this.pageController,
    required this.index,
  });

  final Status status;

  /// Status index.
  final int index;

  /// The [StatusPageView] controller.
  ///
  /// To stop animation on page scroll.
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? _StatusScreenMobile(
            status: status,
            index: index,
            pageController: pageController,
          )
        : _StatusScreenDesktop(status: status, pageController: pageController);
  }
}

class _StatusScreenMobile extends StatefulWidget {
  const _StatusScreenMobile({
    Key? key,
    required this.status,
    required this.pageController,
    required this.index,
  }) : super(key: key);

  final Status status;

  /// Status index.
  final int index;

  /// The [StatusPageView] controller.
  ///
  /// To stop animation on page scroll.
  final PageController pageController;

  @override
  State<_StatusScreenMobile> createState() => _StatusScreenMobileState();
}

class _StatusScreenMobileState extends State<_StatusScreenMobile>
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
    _pageController.addListener(_pageListener);
  }

  late final _statusBloc = context.read<StatusBloc>();

  /// Status page view controller.
  late final _pageController = widget.pageController;

  /// Show next status when animation completed.
  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _next();
  }

  /// Current page in PageView.
  /// Used to animate pages on swipe.
  late double _page = widget.index.toDouble();

  /// Pause the animation while page swiping.
  void _pageListener() {
    setState(() => _page = _pageController.page!);

    if (_page - _page.floor() != 0) {
      _pause();
    }
  }

  /// Play/Continue the status progress animation.
  void _play() {
    _controller.forward();
    _appBarVisible.value = true;
  }

  /// Pause the status progress animation.
  void _pause() => _controller.stop();

  /// Animate to next status page.
  /// If it is the last status then pop the screen.
  void _next() {
    if (_page == _statusBloc.state.statuses.length - 1) {
      return Navigator.of(context).pop();
    }

    _pageController.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }

  /// Animate to previous status page.
  /// If it is the first status then continue the animation.
  void _prev() {
    if (_page == 0) return _play();

    _pageController.previousPage(
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }

  /// Whether the appBar is visible or not.
  /// AppBar will hide after long press.
  final _appBarVisible = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _controller.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    _pageController.removeListener(_pageListener);
    _appBarVisible.dispose();
    super.dispose();
  }

  /// The whole status content.
  /// Extracted to a field to reuse in Transform widget in the build method.
  late final _statusContent = Scaffold(
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
        child: _AppBar.mobile(
          status: widget.status,
          animation: _controller,
        ),
      ),
    ),
    body: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _pause(),
      onTapUp: (details) {
        // Show previous status if use tap on left edge of the screen.
        // Otherwise show next status.
        if (details.globalPosition.dx <= 80) return _prev();
        _next();
      },
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
                _statusBloc.add(StatusViewed(status: widget.status));
              }
            }
          },
          child: Image.network(widget.status.content.imgUrl!),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Transform(
      // * 0.3 used to decrease spacing between pages
      transform: Matrix4.identity()..rotateZ((widget.index - _page) * 0.3),
      alignment: Alignment.bottomCenter,
      child: _statusContent,
    );
  }
}

class _StatusScreenDesktop extends StatefulWidget {
  const _StatusScreenDesktop({
    Key? key,
    required this.status,
    required this.pageController,
  }) : super(key: key);

  final Status status;

  /// The [StatusPageView] controller.
  ///
  /// To stop animation on page scroll.
  final PageController pageController;

  @override
  State<_StatusScreenDesktop> createState() => _StatusScreenDesktopState();
}

class _StatusScreenDesktopState extends State<_StatusScreenDesktop>
    with SingleTickerProviderStateMixin {
  /// Controller for status progress bar animation.
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  /// Notify when progress animation play or pause.
  ///
  /// To update the play/pause icon on appBar (desktop).
  final _isAnimating = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_animationStatusListener);
  }

  late final _statusBloc = context.read<StatusBloc>();

  /// Status page view controller.
  late final _pageController = widget.pageController;

  /// Show next status when animation completed.
  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _next();
  }

  /// Play/Continue the status progress animation.
  void _play() {
    _controller.forward();
    _isAnimating.value = true;
  }

  /// Pause the status progress animation.
  void _pause() {
    _controller.stop();
    _isAnimating.value = false;
  }

  /// Animate to next status page.
  /// If it is the last status then pop the screen.
  void _next() {
    if (_pageController.page! == _statusBloc.state.statuses.length - 1) {
      return Navigator.of(context).pop();
    }

    _pageController.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    _isAnimating.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        // +20 for status progress bar + top padding (5+15)
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: _AppBar.desktop(
          status: widget.status,
          animation: _controller,
          isAnimatingNotifier: _isAnimating,
          play: _play,
          pause: _pause,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _pause(),
        onTapUp: (_) => _play(),

        // Status image
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background blur image
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Image.network(
                widget.status.content.imgUrl!,
                fit: BoxFit.cover,
              ),
            ),

            // To darken the blur image
            const ColoredBox(color: Colors.black45),

            // Actual status image
            Center(
              child: VisibilityDetector(
                key: ValueKey(widget.status.id),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction == 1) {
                    _play();
                    if (!widget.status.isSeen) {
                      _statusBloc.add(StatusViewed(status: widget.status));
                    }
                  }
                },
                child: Image.network(widget.status.content.imgUrl!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar.mobile({
    Key? key,
    required this.status,
    required this.animation,
  })  : isAnimatingNotifier = null,
        play = null,
        pause = null,
        super(key: key);

  const _AppBar.desktop({
    Key? key,
    required this.status,
    required this.animation,
    required this.isAnimatingNotifier,
    required this.play,
    required this.pause,
  })  : assert(isAnimatingNotifier != null && play != null && pause != null),
        super(key: key);

  final Status status;

  /// Progress bar animation.
  final Animation<double> animation;

  // Only on desktop
  /// Notified when progress animation play or pause.
  final ValueNotifier<bool>? isAnimatingNotifier;
  final VoidCallback? play;
  final VoidCallback? pause;

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    // Column with status progress bar and appBar
    final appBarWithProgressBar = Column(
      children: [
        // Status progress
        StatusProgressBar(animation: animation),

        AppBar(
          // Elevation for text visibility on white screen
          elevation: 0.1,
          shadowColor: Colors.black26,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          automaticallyImplyLeading: isMobile,
          foregroundColor: Colors.white,
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
          actions: isMobile
              ? null
              : [
                  // Play/Pause button
                  IconButton(
                    onPressed: () {
                      if (isAnimatingNotifier!.value) return pause!();
                      play!();
                    },
                    icon: ValueListenableBuilder<bool>(
                      valueListenable: isAnimatingNotifier!,
                      builder: (context, isAnimating, _) {
                        return Icon(
                          isAnimating ? Icons.pause : Icons.play_arrow,
                        );
                      },
                    ),
                  ),

                  // Mute button
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.volume_off),
                  ),
                ],
        ),
      ],
    );

    if (isMobile) return SafeArea(child: appBarWithProgressBar);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15).copyWith(bottom: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BackButton(color: Colors.white),

            // AppBar with progress bar
            Flexible(
              child: SizedBox(
                width: 600,
                child: appBarWithProgressBar,
              ),
            ),

            // Close button
            IconButton(
              icon: const Icon(Icons.close),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                // Pop the StatusScreen
                Navigator.of(context).pop();
                // Pop the StatusListView screen
                context.read<StatusListViewCubit>().pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
