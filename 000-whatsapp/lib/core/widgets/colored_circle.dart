import 'package:flutter/material.dart';

class ColoredCircle extends StatelessWidget {
  /// Create a circle with given [color].
  const ColoredCircle({
    super.key,
    required this.color,
    this.dimension = 20.0,
    this.child,
  });

  /// Background color.
  final Color color;

  /// Dimension for ColoredCircle.
  ///
  /// Default to `20.0`.
  final double? dimension;

  /// If non-null, then shows in center of ColoredCircle.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: ClipOval(
        child: ColoredBox(
          color: color,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
