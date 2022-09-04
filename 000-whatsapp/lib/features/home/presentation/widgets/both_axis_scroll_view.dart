import 'package:flutter/material.dart';

class BothAxisScrollView extends StatelessWidget {
  BothAxisScrollView({
    super.key,
    required this.child,
  });

  final Widget child;

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _verticalScrollController,
      thumbVisibility: true,
      child: Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: true,
        notificationPredicate: (_) => true,
        child: SingleChildScrollView(
          controller: _verticalScrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: child,
          ),
        ),
      ),
    );
  }
}
