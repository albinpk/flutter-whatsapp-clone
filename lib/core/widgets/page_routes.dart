import 'package:flutter/material.dart';

import '../../features/chat/features/user_profile/presentation/screens/user_profile_screen.dart';

// Common page transitions

class SlidePageRoute extends PageRouteBuilder {
  /// Slide the page to view (from left).
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

class NoAnimationPageRoute extends PageRouteBuilder {
  /// PageRouteBuilder without animation.
  NoAnimationPageRoute({
    required WidgetBuilder builder,
  }) : super(
          pageBuilder: (context, _, __) => builder(context),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
}

class FadePageRoute extends PageRouteBuilder {
  /// Fade in the route to view.
  ///
  /// Used in [UserProfileScreen] transition in mobile.
  FadePageRoute({
    required WidgetBuilder builder,
  }) : super(pageBuilder: (context, _, __) => builder(context));

  @override
  RouteTransitionsBuilder get transitionsBuilder => (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      };
}
