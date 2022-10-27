import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../status.dart';

/// The PageView containing all statuses.
class StatusPageView extends StatefulWidget {
  const StatusPageView({
    super.key,
    required this.initialPage,
  });

  /// Initial page index.
  final int initialPage;

  @override
  State<StatusPageView> createState() => _StatusPageViewState();
}

class _StatusPageViewState extends State<StatusPageView> {
  late final _pageController = PageController(initialPage: widget.initialPage);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statuses = context.watch<StatusBloc>().state.statuses;
    return PageView.builder(
      controller: _pageController,
      itemCount: statuses.length,
      itemBuilder: (context, index) {
        return StatusScreen(
          status: statuses[index],
          pageController: _pageController,
        );
      },
    );
  }
}
