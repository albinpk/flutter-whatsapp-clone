import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions/target_platform.dart';
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

  // _isFirst and _isLast is only used in desktop
  // to show/hide next/previous buttons.

  /// Whether the initialPage is the first status or not.
  late bool _isFirst = widget.initialPage == 0;

  /// Whether the initialPage is the last status or not.
  late bool _isLast = widget.initialPage ==
      context.read<StatusBloc>().state.statuses.length - 1;

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile;
    final statuses = context.watch<StatusBloc>().state.statuses;

    //
    final statusPageView = PageView.builder(
      controller: _pageController,
      itemCount: statuses.length,
      onPageChanged: isMobile
          ? null
          : (page) {
              // Next/Previous buttons always shows if page>1 && page<length-2
              if (page > 1 && page < statuses.length - 2) return;
              setState(() {
                _isFirst = page == 0;
                _isLast = page == statuses.length - 1;
              });
            },
      itemBuilder: (context, index) {
        return StatusScreen(
          status: statuses[index],
          index: index,
          pageController: _pageController,
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: isMobile
          ? statusPageView
          : Stack(
              children: [
                statusPageView,

                // Previous buttons
                if (!_isFirst)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: IconButton(
                        onPressed: _prev,
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                  ),

                // Next buttons
                if (!_isLast)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: IconButton(
                        onPressed: _next,
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  // _next and _prev methods only used in desktop platform.

  /// Animate to next status page.
  void _next() {
    _pageController.nextPage(
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }

  /// Animate to previous status page.
  void _prev() {
    _pageController.previousPage(
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }
}
