import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../user_profile.dart';

const _expandedHeight = 130.0;

class UserProfileAppBar extends StatefulWidget {
  const UserProfileAppBar({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// Animation to change user DP radius on scroll
  late final Animation<double> _dpRadiusAnimation;

  /// Animation to slide user name from left to right (behind user DP)
  late final Animation<double> _nameLeftAnimation;

  /// Animation to clip user name behind user DP (also slide to right)
  late final Animation<double> _nameWidthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    widget.scrollController.addListener(_scrollListener);

    _dpRadiusAnimation = Tween<double>(
      begin: 55,
      end: 20,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    // Start slide animation on 50%
    _nameLeftAnimation = Tween<double>(
      begin: 5,
      end: 60,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );

    // User name clipping, from 40% - 80%
    _nameWidthAnimation = Tween<double>(
      begin: 0.4,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  /// Update animation value on scroll
  void _scrollListener() {
    final offset = widget.scrollController.offset;
    const max = _expandedHeight - kToolbarHeight;
    // Convert offset range to animation range (0-1)
    final value = (offset / max).clamp(0.0, 1.0);
    if (value != _controller.value) _controller.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final topPadding = mediaQuery.padding.top;

    // Animate user DP form center to top left corner on scroll
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return SliverAppBar(
          leading: BackButton(
            onPressed: () {
              context.read<UserProfileBloc>().add(const UserProfileClose());
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: ColorTween(
            begin: CustomColors.of(context).background!,
            end: CustomColors.of(context).secondary,
          ).evaluate(
            CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.3, 1, curve: Curves.ease),
            ),
          ),
          pinned: true,
          expandedHeight: _expandedHeight,
          flexibleSpace: Stack(
            children: [
              // User dp and user name.
              // Using nested Stack to hide username behind user dp.
              Positioned(
                top: (kToolbarHeight - 20 * 2) / 2 + topPadding,
                left: Tween<double>(
                  begin: screenWidth / 2 - (55 * 2 / 2),
                  end: 50,
                ).evaluate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.ease,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // User name
                    Positioned(
                      left: _nameLeftAnimation.value,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.centerRight,
                          widthFactor: _nameWidthAnimation.value,
                          child: Text(
                            context.select((WhatsAppUser user) => user.name),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),

                    // User DP
                    Hero(
                      tag: context.select((WhatsAppUser user) => user.id),
                      child: UserDP(radius: _dpRadiusAnimation.value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
