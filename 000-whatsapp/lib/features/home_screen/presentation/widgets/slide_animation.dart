import 'package:flutter/material.dart';

/// Animate the given [child] on initState.
///
/// Used to animate initial route in desktop
class SlideAnimation extends StatefulWidget {
  /// Animate the given [child] on initState.
  ///
  /// Wrap the given [child] with [SlideTransition]
  /// and start the animation in initState().
  ///
  /// Control the animation by giving a [SlideAnimationController]
  /// to [controller] parameter.
  const SlideAnimation({
    Key? key,
    required this.child,
    this.controller,
  }) : super(key: key);

  final Widget child;

  /// Controller for [SlideAnimation].
  final SlideAnimationController? controller;

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController and start animation.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();

    // Attaching controller
    widget.controller?._forward = _animationController.forward;
    widget.controller?._reverse = _animationController.reverse;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: widget.child,
    );
  }
}

/// Controller for [SlideAnimation].
class SlideAnimationController {
  // This function will attach to AnimationController.forward().
  TickerFuture Function()? _forward;

  /// Run the animation in forward direction.
  TickerFuture? show() => _forward?.call();

  // This function will attach to AnimationController.reverse().
  TickerFuture Function()? _reverse;

  /// Run the animation in reverse direction.
  TickerFuture? hide() => _reverse?.call();

  /// Reset the callback handlers to `null`.
  void dispose() {
    _forward = null;
    _reverse = null;
  }
}
