import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/models.dart';
import '../../../../../../core/utils/extensions/target_platform.dart';
import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../user_profile.dart';

class UserProfileAppBar extends StatelessWidget {
  const UserProfileAppBar({
    super.key,
    required this.scrollController,
  });

  /// To animate UserDP on scroll. Only used in mobile.
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform.isMobile
        ? _UserProfileAppBarMobile(scrollController: scrollController)
        : const _UserProfileAppBarDesktop();
  }
}

class _UserProfileAppBarMobile extends StatefulWidget {
  const _UserProfileAppBarMobile({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  State<_UserProfileAppBarMobile> createState() =>
      _UserProfileAppBarMobileState();
}

class _UserProfileAppBarMobileState extends State<_UserProfileAppBarMobile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// Animation to change user DP radius on scroll
  late final Animation<double> _dpRadiusAnimation;

  /// Animation to slide user name from left to right (behind user DP)
  late final Animation<double> _nameLeftAnimation;

  /// Animation to clip user name behind user DP (also slide to right)
  late final Animation<double> _nameWidthAnimation;

  /// AppBar expanded height
  static const _expandedHeight = 130.0;

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
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);

    // Animate user DP form center to top left corner on scroll
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return SliverAppBar(
          leading: BackButton(
            color: theme.brightness == Brightness.dark
                ? customColors.onSecondary
                : ColorTween(
                    begin: customColors.onBackgroundMuted,
                    end: customColors.onSecondary,
                  ).evaluate(_controller),
            onPressed: () {
              context.read<UserProfileBloc>().add(const UserProfileClose());
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: ColorTween(
            begin: customColors.background,
            end: customColors.secondary,
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
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: customColors.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // User DP
                    Hero(
                      tag: context.select((WhatsAppUser user) => user.id),
                      child: UserDP(
                        radius: _dpRadiusAnimation.value,
                        url: context.select((WhatsAppUser user) => user.dpUrl),
                      ),
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

class _UserProfileAppBarDesktop extends StatelessWidget {
  const _UserProfileAppBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: IconButton(
        onPressed: () {
          context.read<UserProfileBloc>().add(const UserProfileClose());
        },
        icon: const Icon(Icons.close),
      ),
      title: const Text('Contact info'),
    );
  }
}
