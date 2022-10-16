import 'package:flutter/material.dart';

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
