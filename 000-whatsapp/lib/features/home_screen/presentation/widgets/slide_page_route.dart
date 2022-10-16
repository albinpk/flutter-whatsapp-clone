import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  /// Slide the page to view.
  ///
  /// Used for navigation in desktop.
  SlidePageRoute({
    required WidgetBuilder builder,
  }) : super(
          pageBuilder: (context, _, __) => builder(context),
          transitionDuration: _duration,
          reverseTransitionDuration: _duration,
        );

  /// Duration for forward and reverse transition.
  static const _duration = Duration(milliseconds: 200);

  @override
  RouteTransitionsBuilder get transitionsBuilder => (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: child,
        );
      };
}
